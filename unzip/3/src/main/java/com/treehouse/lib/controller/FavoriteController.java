package com.treehouse.lib.controller;

import com.treehouse.lib.data.GifRepository;
import com.treehouse.lib.model.Category;
import com.treehouse.lib.model.Gif;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Created by admin on 2016-12-28.
 */
@Controller
public class FavoriteController {
    @Autowired
    private GifRepository gifRepository;

    @RequestMapping("/favorites")
    public String favorite(ModelMap modelMap){
        List<Gif> gifs = gifRepository.findByfavorite();
        modelMap.put("gifs", gifs);
        return "favorites";
    }

}
