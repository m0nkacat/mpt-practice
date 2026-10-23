package org.example.pr6.repository;

import org.example.pr6.model.TagsModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TagsRepository extends JpaRepository<TagsModel, Integer> {
}