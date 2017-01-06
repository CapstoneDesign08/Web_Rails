package com.treehouse.lib.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Created by admin on 2016-12-27.
 */
public class Gif {
    private String name;
    private int categoryid;
    private LocalDate dateUploaded;
    private String username;
    private boolean favorite;

    public Gif(String name, int categoryid, LocalDate dateUploaded, String username, boolean favorite) {
        this.name = name;
        this.categoryid = categoryid;
        this.dateUploaded = dateUploaded;
        this.username = username;
        this.favorite = favorite;
    }


    public int getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(int categoryid) {
        this.categoryid = categoryid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalDate getDateUploaded() {
        return dateUploaded;
    }

    public void setDateUploaded(LocalDate dateUploaded) {
        this.dateUploaded = dateUploaded;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isFavorite() {
        return favorite;
    }

    public void setFavorite(boolean favorite) {
        this.favorite = favorite;
    }
}
