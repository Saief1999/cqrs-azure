import { AzureFunction, Context } from "@azure/functions"
import { Client } from "@elastic/elasticsearch";
import { cp } from "fs";
import { UpdateMessage } from "./dtos/update-message";


const esClient = new Client({
    node: process.env["elasticsearch_uri"]
})

const movieIndex = "movie";

const eventGridTrigger: AzureFunction = async function (context: Context, eventGridEvent: any): Promise<void> {
    const updateMessage: UpdateMessage = eventGridEvent.data

    context.log("Received This object => " + JSON.stringify(updateMessage));

    if (updateMessage && updateMessage.isDeleted === true) {
        await esClient.delete({
            id: updateMessage.movie.id,
            index: movieIndex
        })

        context.log("Deleted movie with id => " + updateMessage.movie.id);
    }
    else if (updateMessage && updateMessage.isDeleted === false) {
        const { id: movieId, ...movieData } = updateMessage.movie;

        await esClient.update({
            index: movieIndex,
            id: movieId,
            body: {
                doc: movieData,
                doc_as_upsert: true
            }
        });

        context.log("Upserted movie => " + JSON.stringify(updateMessage.movie));
    }
};

export default eventGridTrigger;
