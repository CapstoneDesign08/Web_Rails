package com.treehouse.lib.data;

import com.treehouse.lib.model.Gif;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by admin on 2016-12-27.
 */
@Component
public class GifRepository {
    private static final List<Gif> ALL_GIFS = Arrays.asList(
           // new Gif("f798b87cda1f0eeb8765e19e2371477a",1, LocalDate.of(2015,2,13), "Chris Ramacciotti", true),
            new Gif("cat",2, LocalDate.of(2015,2,13), "Chris Ramacciotti", false),
            new Gif("android-explosion",3, LocalDate.of(2015,2,13), "Chris Ramacciotti", false),
            new Gif("ben-and-mike",1, LocalDate.of(2015,10,30), "Ben Jakuben", true),
            new Gif("book-dominos",2, LocalDate.of(2015,9,15), "Craig Dennis", false),
            new Gif("compiler-bot",3, LocalDate.of(2015,2,13), "Ada Lovelace", true),
            new Gif("cowboy-coder",1, LocalDate.of(2015,2,13), "Grace Hopper", false),
            new Gif("infinite-andrew",2, LocalDate.of(2015,8,23), "Marissa Mayer", true)
    );

    public static Gif findByName(String name){
        for(Gif gif : ALL_GIFS){
            if(gif.getName().equals(name)){
                return gif;
            }
        }
        return null;
    }
    public List<Gif> findBycategoryId(int id){
        // 빈 리스트에 id에 해당하는 Gif object를 추가
        List<Gif> gifs = new ArrayList<>();
        for(Gif gif : ALL_GIFS){
            if(gif.getCategoryid() == id){
                gifs.add(gif);
            }
        }
        return gifs;
    }

    public List<Gif> findByfavorite(){
        List<Gif> gifs = new ArrayList<>();
        for(Gif gif : ALL_GIFS){
            if(gif.isFavorite() == true){
                gifs.add(gif);
            }
        }
        return gifs;
    }

    public List<Gif> getAllGifs(){

        return ALL_GIFS;
    }
}
