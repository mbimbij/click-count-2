package fr.xebia.clickcount.controller;

import fr.xebia.clickcount.repository.ClickRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ClickRestController {

  @Autowired
  private ClickRepository clickRepository;

  @GetMapping("click")
  public long getCount() {
    return clickRepository.getCount();
  }

  @PostMapping("click")
  public long incrementCount() {
    return clickRepository.incrementAndGet();
  }

  @GetMapping("healthcheck")
  public String healthcheck() {
    String result = clickRepository.ping();
    if ("PONG".equals(result)) {
      return "ok";
    }
    return "ko : " + result;
  }

}
