package org.example.pr6.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "Answers")
public class AnswersModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer answerId;

    @ManyToOne(optional = false)
    @JoinColumn(name = "question_id")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private QuestionsModel question;

    @NotBlank(message = "Текст ответа не может быть пустым")
    private String body;

    private boolean isAccepted;

    public AnswersModel() {}

    public AnswersModel(Integer answerId, String body, boolean isAccepted) {
        this.answerId = answerId;
        this.body = body;
        this.isAccepted = isAccepted;
    }

    public Integer getAnswerId() { return answerId; }
    public void setAnswerId(Integer answerId) { this.answerId = answerId; }

    public QuestionsModel getQuestion() { return question; }
    public void setQuestion(QuestionsModel question) { this.question = question; }

    public String getBody() { return body; }
    public void setBody(String body) { this.body = body; }

    public boolean isAccepted() { return isAccepted; }
    public void setAccepted(boolean accepted) { isAccepted = accepted; }
}