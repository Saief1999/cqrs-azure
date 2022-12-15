package com.example.upsertmicroservice.producers;

import com.azure.core.credential.AzureKeyCredential;
import com.azure.core.util.BinaryData;
import com.azure.messaging.eventgrid.EventGridEvent;
import com.azure.messaging.eventgrid.EventGridPublisherClient;
import com.azure.messaging.eventgrid.EventGridPublisherClientBuilder;
import com.example.upsertmicroservice.pojos.UpdateMessage;
import org.springframework.beans.factory.annotation.Value;
//import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

//import java.util.logging.Logger;

@Service
public class Producer {

//    @Value("${kafka.topic}")
//    private String projectorTopic;
//
//    private KafkaTemplate<String, UpdateMessage> kafkaTemplate;
//
//    public Producer(KafkaTemplate kafkaTemplate) {
//        this.kafkaTemplate = kafkaTemplate;
//    }
//
//    public void sendUpdate(UpdateMessage updateMessage) {
//        System.out.println(String.format("#### -> Producing message -> %s", updateMessage));
//        this.kafkaTemplate.send(projectorTopic, updateMessage);
//    }

    private EventGridPublisherClient<EventGridEvent> eventGridClient;

    public Producer(EventGridPublisherClient<EventGridEvent> eventGridClient) {
        this.eventGridClient = eventGridClient;
    }

    public void sendUpdate(UpdateMessage updateMessage) {
        System.out.println(String.format("#### -> Producing message -> %s", updateMessage));

        EventGridEvent event = new EventGridEvent(
                "synchronization-event",
                "Com.Example.SyncEventType",
                BinaryData.fromObject(updateMessage),
                "0.1");

        this.eventGridClient.sendEvent(event);
    }
}
