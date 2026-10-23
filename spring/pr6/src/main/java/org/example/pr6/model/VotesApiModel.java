package org.example.pr6.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "Votes")
public class VotesModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer voteId;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private UserModel user;

    @ManyToOne(optional = false)
    @JoinColumn(name = "question_id")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private QuestionsModel question;

    @ManyToOne(optional = true)
    @JoinColumn(name = "answer_id")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private AnswersModel answer;

    @NotNull(message = "Тип голоса обязателен")
    @Min(value = -1, message = "Голос должен быть -1 или 1")
    @Max(value = 1, message = "Голос должен быть -1 или 1")
    private Integer voteType;

    public VotesModel() {}

    public VotesModel(Integer voteId, UserModel user, QuestionsModel question, AnswersModel answer, Integer voteType) {
        this.voteId = voteId;
        this.user = user;
        this.question = question;
        this.answer = answer;
        this.voteType = voteType;
    }

    public Integer getVoteId() { return voteId; }
    public void setVoteId(Integer voteId) { this.voteId = voteId; }

    public UserModel getUser() { return user; }
    public void setUser(UserModel user) { this.user = user; }

    public QuestionsModel getQuestion() { return question; }
    public void setQuestion(QuestionsModel question) { this.question = question; }

    public AnswersModel getAnswer() { return answer; }
    public void setAnswer(AnswersModel answer) { this.answer = answer; }

    public Integer getVoteType() { return voteType; }
    public void setVoteType(Integer voteType) { this.voteType = voteType; }
}