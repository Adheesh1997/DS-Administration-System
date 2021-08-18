package co4353distributedsystems.apigateway;

import co4353distributedsystems.apigateway.routingandfiltergateway.SimpleFilter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;
import org.springframework.context.annotation.Bean;


@EnableDiscoveryClient
@EnableZuulProxy
@SpringBootApplication
public class ApigatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(ApigatewayApplication.class, args);
    }
    @Bean
    public SimpleFilter simpleFilter() {
        return new SimpleFilter();
    }
}
