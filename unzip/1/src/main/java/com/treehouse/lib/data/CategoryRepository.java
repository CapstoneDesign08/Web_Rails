package com.treehouse.lib.data;

import com.treehouse.lib.model.Category;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

/**
 * Created by admin on 2016-12-28.
 */
@Component
public class CategoryRepository {
    private static List<Category> ALL_CATEGORIES = Arrays.asList(
            new Category(1, "Hong"),
            new Category(2, "Gyu"),
            new Category(3, "Hyeok")
    );

    public static List<Category> getAllCategories() {
        return ALL_CATEGORIES;
    }

    public Category findById(int id) {
        for(Category category : ALL_CATEGORIES){
            if(category.getId() == id){
                return category;
            }
        }
        return null;
    }
}
