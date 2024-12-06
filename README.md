<a id="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Ben-Long50/pawprint-backend.git">
    <img src="public/paw.svg" alt="Logo" width="80" height="80">
  </a>

<h1 align="center">Pawprint API</h1>

  <p align="center">
    The backend API which powers my Pawprint social media website
    <br />
    <a href="https://github.com/Ben-Long50/pawprint-backend.git"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://pawprint-social.com/">View Demo</a>
    ·
    <a href="https://github.com/Ben-Long50/pawprint-backend/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/Ben-Long50/pawprint-backend/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#features">Features</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

### Built With

<a href="https://nodejs.org">
  <img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=node.js&logoColor=white" height="40" alt="Node.js">
</a>

<a href="https://expressjs.com">
  <img src="https://img.shields.io/badge/Express-000000?style=for-the-badge&logo=express&logoColor=white" height="40" alt="Express">
</a>

<a href="https://www.postgresql.org">
  <img src="https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white" height="40" alt="PostgreSQL">
</a>

<a href="https://www.prisma.io">
  <img src="https://img.shields.io/badge/Prisma-2D3748?style=for-the-badge&logo=prisma&logoColor=white" height="40" alt="Prisma">
</a>

<a href="http://www.passportjs.org">
  <img src="https://img.shields.io/badge/Passport.js-34E27A?style=for-the-badge&logo=passport&logoColor=white" height="40" alt="Passport.js">
</a>

### API Endpoints

#### Authentication Endpoints

| Method | Endpoint             | Description                                                     |
| ------ | -------------------- | --------------------------------------------------------------- |
| GET    | `/auth/google`       | Signs a user in using Google OAuth and returns a session cookie |
| GET    | `/auth/facebook`     | Signs a user in using Facebook and returns a session cookie     |
| GET    | `/auth/status`       | Returns a boolean reflecting current auth status                |
| POST   | `/auth/signin`       | Signs a user in an returns a session cookie                     |
| POST   | `/auth/signout`      | Signs a user out and deleted their session and session cookie   |
| POST   | `/auth/signup`       | Registers a new user locally                                    |
| POST   | `/auth/signin/guest` | Signs in a user after creating a temporary guest account        |

#### User Endpoints

| Method | Endpoint | Description                                            |
| ------ | -------- | ------------------------------------------------------ |
| GET    | `/users` | Retrieves details of the currently authenticated user  |
| PUT    | `/users` | Updates the currently authenticated user's information |
| DELETE | `/users` | Deletes the currently authenticated user               |

#### Profile Endpoints

| Method | Endpoint                                 | Description                                                        |
| ------ | ---------------------------------------- | ------------------------------------------------------------------ |
| GET    | `/profiles`                              | Fetches the current users profiles                                 |
| GET    | `/profiles/active`                       | Fetches the current users active profile                           |
| GET    | `/profiles/:profileId`                   | Fetches a specific profile                                         |
| GET    | `/profiles/:profileId/posts`             | Fetches the posts of a specific profile                            |
| GET    | `/profiles/:profileId/bookmarks`         | Fetches the bookmarks of a specific profile                        |
| GET    | `/profiles/:profileId/notifications`     | Fetches the notifications of a specific profile                    |
| GET    | `/profiles/:profileId/searches`          | Fetches the search history of a specific profile                   |
| GET    | `/profiles/:activeId/follows/:profileId` | Returns a boolean reflecting the follow status                     |
| POST   | `/profiles`                              | Creates a new profile                                              |
| POST   | `/profiles/:profileId/follows`           | Follows a specific profile with the current users active profile   |
| POST   | `/profiles/:profileId/bookmarks`         | Creates a new bookmark on the active profile                       |
| DELETE | `/profiles/:profileId`                   | Deletes a specific profile                                         |
| DELETE | `/profiles/:profileId/follows`           | Unfollows a specific profile with the current users active profile |
| DELETE | `/profiles/:profileId/bookmarks/:postId` | Deletes a bookmark corresponding to a specific post                |

#### Post Endpoints

| Method | Endpoint                             | Description                                       |
| ------ | ------------------------------------ | ------------------------------------------------- |
| GET    | `/posts`                             | Fetches the most recent posts of followed users   |
| GET    | `/posts/explore`                     | Fetches the most recent posts of unfollowed users |
| GET    | `/posts/:postId/comments`            | Fetches a specific posts comments                 |
| POST   | `/posts`                             | Creates a new post                                |
| POST   | `/posts/:postId/likes`               | Likes a specific post                             |
| POST   | `/posts/:postId/comments`            | Comments on a specific post                       |
| DELETE | `/posts/:postId`                     | Deletes a specific post.                          |
| DELETE | `/posts/:postId/likes`               | Removes the current users like on a specific post |
| DELETE | `/posts/:postId/comments/:commentId` | Deletes a specific comment on a post              |

#### Comment Endpoints

| Method | Endpoint                     | Description                                          |
| ------ | ---------------------------- | ---------------------------------------------------- |
| POST   | `/comments/:commentId/likes` | Likes a specific comment                             |
| DELETE | `/comments/:commentId/likes` | Removes the current users like on a specific comment |

#### Notification Endpoints

| Method | Endpoint                         | Description                                           |
| ------ | -------------------------------- | ----------------------------------------------------- |
| POST   | `/notifications`                 | Creates a share notification                          |
| DELETE | `/notifications`                 | Deletes all notifications on the active profile       |
| DELETE | `/notifications/:notificationId` | Deletes a specific notification on the active profile |

#### Search Endpoints

| Method | Endpoint               | Description                                                                                   |
| ------ | ---------------------- | --------------------------------------------------------------------------------------------- |
| GET    | `/search/:searchQuery` | Returns a list of profiles matching the requested query string                                |
| GET    | `/search/:profileId`   | Creates a search history entry for the searched profile on the users currently active profile |
| DELETE | `/search/:profileId`   | Deletes a search history entry pertaining to a specific profile                               |
| DELETE | `/search`              | Deletes all search history entries                                                            |

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

To access the live version of this project and explore all of it's features, use the official website link below. Otherwise, continue with the following instructions to run the project locally

<a href="https://pawprint-social.com">
  <strong>Pawprint »</strong>
</a>

### Prerequisites

1. To use the Pawprint API effectively, you will need to set up the GUI for local use. Please take a look at the instructions regarding the setup for the GUI in the following link:

   <a href="https://github.com/Ben-Long50/pawprint-frontend.git"><strong>Pawprint frontend repo »</strong></a>

2. You will need to have psql installed locally

### Installation

1. **Clone the repository**  
   Run the following command to clone the repository:
   ```sh
   git clone https://github.com/Ben-Long50/pawprint-backend.git
   ```
2. **Navigate to the project directory and install dependencies**  
   Move into the project directory and install the required npm packages:
   ```sh
   cd pawprint-backend
   npm install
   ```
3. **Set up a local development database for the project**  
   Open a second terminal and create a new database in psql. Connect to it:
   ```sh
   psql
   CREATE DATABASE <your_database_name>
   \c <your_database_name>
   ```
   Return to the first terminal where you are located in the pawprint-backend directory and migrate the database schema:
   ```sh
   npx prisma generate
   npx prisma migrate dev
   ```
   In the psql terminal, check that the schema has been successfully migrated over to the development db:
   ```sh
   \d
   ```
4. **Set up an account on Cloudinary**  
   <a href="https://www.cloudinary.com/">
   <strong>Cloudinary »</strong>
   </a>  
   Find the cloud name, api key and api secret associated with your account. They will be used as env variables in the next section
5. **Set up environment variables**  
    Create a .env file in the project’s base directory and add the following environment variables:
   ```js
   CLIENT_URL = 'http://localhost:5173';
   API_URL = 'http://localhost:3000';
   DATABASE_URL =
     'postgresql://<your_psql_username>:<your_psql_password>@localhost:5432/<your_database_name>';
   SECRET_KEY = '<your_session_key>';
   CLOUD_NAME = '<your_cloudinary_cloud_name>';
   API_KEY = '<your_cloudinary_api_key>';
   API_SECRET = '<your_cloudinary_api_secret>';
   FACEBOOK_SECRET = '<your_facebook_developer_secret>';
   FACEBOOK_ID = '<your_facebook_developer_id>';
   GOOGLE_SECRET = '<your_google_developer_secret>';
   GOOGLE_ID = '<your_google_developer_id>';
   NODE_ENV = 'development';
   ```
   > [!NOTE]
   > For the scope of this install tutorial, we will not cover setting up the facebook and google auth options. Use the local auth option for testing
6. **Avoid accidental pushes to the original repository**  
   If you plan to make changes, update the Git remote to point to your own fork to prevent accidental pushes to the base repository:

   ```sh
   git remote set-url origin https://github.com/<your_github_username>/pawprint-backend.git
   ```

   Confirm the change:

   ```sh
   git remote -v
   ```

   You should see:

   ```sh
   origin  https://github.com/<your_github_username>/pawprint-backend.git (fetch)
   origin  https://github.com/<your_github_username>/pawprint-backend.git (push)
   ```

7. **Start the Development Server**  
   Run the following command to start the app:
   ```sh
   npm run serverstart
   ```
8. **Start the frontend dev server and access it in browser on port 5173**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Ben Long - [LinkedIn](https://www.linkedin.com/in/ben-long-4ba566129/)

Email - benjlong50@gmail.com

Project Link - [https://github.com/Ben-Long50/pawprint-backend](https://github.com/Ben-Long50/pawprint-backend)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
