package fr.xebia.clickcount;

import fr.xebia.clickcount.repository.ClickRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SpringBootConfiguration {
    @Bean
    public ClickRepository redisClickRepository(RedisConfiguration redisConfiguration){
        return new ClickRepository(redisConfiguration);
    }
}
