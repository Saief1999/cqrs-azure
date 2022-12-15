package com.example.upsertmicroservice.configurations;

import com.azure.core.credential.AzureKeyCredential;
import com.azure.messaging.eventgrid.EventGridEvent;
import com.azure.messaging.eventgrid.EventGridPublisherClient;
import com.azure.messaging.eventgrid.EventGridPublisherClientBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AzureTopicConfig {
    @Value("${topic-key}")
    private String topicKey;

    @Value("${topic-endpoint}")
    private String topicEndpoint;

    @Bean
    public EventGridPublisherClient<EventGridEvent> eventGridClient () {
        return new EventGridPublisherClientBuilder()
                .endpoint(this.topicEndpoint)
                .credential(new AzureKeyCredential(this.topicKey))
                .buildEventGridEventPublisherClient();
    }

}
