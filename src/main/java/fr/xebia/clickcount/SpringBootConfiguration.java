package fr.xebia.clickcount;

import fr.xebia.clickcount.hexagon.ICheckDataStoreHealth;
import fr.xebia.clickcount.hexagon.ICountClicks;
import fr.xebia.clickcount.hexagon.IRegisterANewClick;
import fr.xebia.clickcount.repository.RedisClickRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SpringBootConfiguration {
    @Bean
    public RedisClickRepository redisClickRepository(RedisConfiguration redisConfiguration){
        return new RedisClickRepository(redisConfiguration);
    }
    @Bean
    public ICountClicks iCountClicks(RedisClickRepository redisClickRepository){
        return redisClickRepository;
    }
    @Bean
    public IRegisterANewClick iRegisterANewClick(RedisClickRepository redisClickRepository){
        return redisClickRepository;
    }
    @Bean
    public ICheckDataStoreHealth iCheckDataStoreHealth(RedisClickRepository redisClickRepository){
        return redisClickRepository;
    }
}
