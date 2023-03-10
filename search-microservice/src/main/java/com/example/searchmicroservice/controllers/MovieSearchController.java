package com.example.searchmicroservice.controllers;

import com.example.searchmicroservice.entities.Movie;
import com.example.searchmicroservice.exceptions.BadRequestException;
import com.example.searchmicroservice.repositories.MovieRepository;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@RestController
public class MovieSearchController {
    private MovieRepository movieRepository;

    public MovieSearchController(
            MovieRepository movieRepository
    ) {
        this.movieRepository = movieRepository;
    }


    @GetMapping("/movies")
    public Iterable<Movie> listMovies()
    {
        return movieRepository.findAll();
//        return new ArrayList<Movie>();
    }

    @GetMapping("/movies/{id}")
    public Movie getMovie(@PathVariable("id") String id) {
        return movieRepository.findById(id).orElseThrow(()-> {
            String errMsg = "Movie Not found with id " + id ;
            return new BadRequestException(BadRequestException.ID_NOT_FOUND, errMsg);
        });

//        Movie movie = new Movie();
//        movie.setDescription("Test Description");
//        movie.setName("Test Name");
//        movie.setId("1");
//        return movie;
    }

    @ExceptionHandler(BadRequestException.class)
    void handleBadRequests(BadRequestException bre, HttpServletResponse response) throws IOException {

        int respCode = (bre.errCode == BadRequestException.ID_NOT_FOUND) ?
                HttpStatus.NOT_FOUND.value() : HttpStatus.BAD_REQUEST.value() ;
        response.sendError(respCode, bre.errCode + ":" + bre.getMessage());
    }
}
