-- Crear la tabla de usuarios
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Añadir 3 usuarios
INSERT INTO users (first_name, last_name, email) VALUES
('Jonathan', 'Rodriguez', 'juan@email.com'),
('Matias', 'Guevara', 'matias@email.com'),
('Pedro', 'Contreras', 'pedro@email.com');

UPDATE users
SET email = 'jonathan@email.com'
WHERE first_name = 'Jonathan' AND last_name = 'Rodriguez';


SELECT * FROM users;

-- Crear la tabla de posts
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    creator_id INTEGER REFERENCES users(id),
    title VARCHAR(100),
    text TEXT
);

-- Añadir 5 posts
INSERT INTO posts (creator_id, title, text) VALUES
(1, 'Post 1', 'Lorem ipsum dolor sit amet'),
(2, 'Post 2', 'Consectetur adipiscing elit'),
(3, 'Post 3', 'Sed do eiusmod tempor incididunt'),
(1, 'Post 4', 'Ut labore et dolore magna aliqua'),
(2, 'Post 5', 'Ut enim ad minim veniam');

-- Crear la tabla de likes
CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    post_id INTEGER REFERENCES posts(id)
);

-- Añadir 5 likes
INSERT INTO likes (user_id, post_id) VALUES
(2, 1),
(3, 1),
(1, 2),
(3, 3),
(1, 5);

-- Traer todos los posts y la información del usuario del campo creator_id
SELECT posts.id, users.first_name || ' ' || users.last_name AS creator, posts.title, posts.text
FROM posts
JOIN users ON posts.creator_id = users.id;

-- Traer todos los posts, con la información de los usuarios que les dieron like
SELECT posts.id, posts.title, posts.text, users.first_name || ' ' || users.last_name AS user_liked
FROM posts
JOIN likes ON posts.id = likes.post_id
JOIN users ON likes.user_id = users.id;
