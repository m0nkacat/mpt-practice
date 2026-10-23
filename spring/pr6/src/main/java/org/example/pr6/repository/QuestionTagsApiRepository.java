package org.example.pr6.repository;

import org.example.pr6.model.QuestionTagsModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionTagsRepository extends JpaRepository<QuestionTagsModel, Integer> {
}