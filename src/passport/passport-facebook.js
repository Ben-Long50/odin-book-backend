import { Strategy as FacebookStrategy } from 'passport-facebook';
import userServices from '../services/userServices.js';
import prisma from '../config/database.js';
import profileServices from '../services/profileServices.js';

const facebookStrategy = (passport) => {
  passport.use(
    new FacebookStrategy(
      {
        clientID: process.env.FACEBOOK_ID,
        clientSecret: process.env.FACEBOOK_SECRET,
        callbackURL: 'https://pawprint-api.onrender.com/auth/facebook/callback',
        profileFields: ['id', 'emails', 'name'],
        scope: ['email'],
      },
      async (accessToken, refreshToken, profile, done) => {
        try {
          const email =
            profile.emails && profile.emails[0]
              ? profile.emails[0].value
              : null;
          let user = await prisma.user.findUnique({
            where: { email },
          });
          if (user) {
            if (user.facebookId !== profile.id) {
              return done(null, false);
            }
          } else {
            const userData = {
              facebookId: profile.id,
              firstName: profile.name.givenName,
              lastName: profile.name.familyName,
              email,
            };
            user = await userServices.createUser(userData);
            await profileServices.createOrUpdateProfile(
              {
                id: 'null',
                username: email,
                petName: 'Default',
                active: true,
              },
              user.id,
            );
          }
          return done(null, user);
        } catch (err) {
          return done(err);
        }
      },
    ),
  );
};

export default facebookStrategy;
