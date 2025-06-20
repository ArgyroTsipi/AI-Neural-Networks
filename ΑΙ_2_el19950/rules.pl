% common genre movies
common_genre(Movie1, Movie2) :-
    genres(Movie1, Genre),
    genres(Movie2, Genre),
    Movie1 \= Movie2.

% at least 3 common genres
shared_genres(Movie1, Movie2, Count) :-
    setof(G, (genres(Movie1, G), genres(Movie2, G)), Genres),
    length(Genres, Count),
    Movie1 \= Movie2.

very_similar_genre(M1, M2) :- shared_genres(M1, M2, C), C >= 3.
moderately_similar_genre(M1, M2) :- shared_genres(M1, M2, C), C == 2.
slightly_similar_genre(M1, M2) :- shared_genres(M1, M2, C), C == 1.

% common director
same_director(M1, M2) :-
    director_name(M1, D),
    director_name(M2, D),
    M1 \= M2.

% common keywords
shared_keywords(Movie1, Movie2, Count) :-
    setof(K, (keywords(Movie1, K), keywords(Movie2, K)), Keywords),
    length(Keywords, Count),
    Movie1 \= Movie2.

identical_plot(M1, M2) :- shared_keywords(M1, M2, C), C >= 5.
similar_plot(M1, M2) :- shared_keywords(M1, M2, C), C >= 2.


% common actors
same_actors(M1, M2) :-
    actor_1_name(M1, A1), actor_1_name(M2, A1),
    actor_2_name(M1, A2), actor_2_name(M2, A2),
    actor_3_name(M1, A3), actor_3_name(M2, A3),
    M1 \= M2.

quite_same_actors(M1, M2) :-
    findall(A, (
        (actor_1_name(M1, A); actor_2_name(M1, A); actor_3_name(M1, A)),
        (actor_1_name(M2, A); actor_2_name(M2, A); actor_3_name(M2, A))
    ), Common),
    list_to_set(Common, Unique),
    length(Unique, N),
    N >= 2.

related_actors(M1, M2) :-
    findall(A, (
        (actor_1_name(M1, A); actor_2_name(M1, A); actor_3_name(M1, A)),
        (actor_1_name(M2, A); actor_2_name(M2, A); actor_3_name(M2, A))
    ), Common),
    list_to_set(Common, Unique),
    length(Unique, N),
    N >= 1.

% common language
same_language(M1, M2) :-
    language(M1, L),
    language(M2, L),
    M1 \= M2.

% same production company
same_company(M1, M2) :-
    production_companies(M1, S),
    production_companies(M2, S),
    M1 \= M2.

% same production country
same_country(M1, M2) :-
    production_countries(M1, C),
    production_countries(M2, C),
    M1 \= M2.

% same decade
same_decade(M1, M2) :-
    release_date(M1, D),
    release_date(M2, D),
    M1 \= M2.

% same color
same_color(M1, M2) :-
    color(M1, C),
    color(M2, C),
    M1 \= M2.

%%%%%%%%%%%%%%%%%%%%% meros 2 %%%%%%%%%%%%%%%

find_sim_1(M1, M2) :-
    genres(M1, Genre),
    genres(M2, Genre),
    M1 \= M2.

% 1: common genre only
find_sim_1(M1, M2) :-
    common_genre(M1, M2).

% 2: common genre and similar plot (>=2 shared keywords)
find_sim_2(M1, M2) :-
    common_genre(M1, M2),
    similar_plot(M1, M2).

% 3: common genre, similar plot, and related actors (>=1 common actor)
find_sim_3(M1, M2) :-
    common_genre(M1, M2),
    similar_plot(M1, M2),
    related_actors(M1, M2).

% 4: common genre, similar plot, related actors, and same production company
find_sim_4(M1, M2) :-
    common_genre(M1, M2),
    similar_plot(M1, M2),
    related_actors(M1, M2),
    same_company(M1, M2).

% 5: common genre, similar plot, related actors, same production company, same_decade
find_sim_5(M1, M2) :-
    common_genre(M1, M2),
    similar_plot(M1, M2),
    related_actors(M1, M2),
    same_company(M1, M2),
    same_decade(M1,M2).
