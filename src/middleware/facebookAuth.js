import passport from 'passport';
import { Strategy as FacebookStrategy } from 'passport-facebook';
import userServices from '../services/userService.js';
import prisma from '../config/database.js';

passport.use(
  new FacebookStrategy(
    {
      clientID: process.env.FACEBOOK_ID,
      clientSecret: process.env.FACEBOOK_SECRET,
      callbackURL: 'http://localhost:3000/auth/facebook/callback',
      profileFields: ['id', 'emails', 'name'],
      scope: ['email'],
    },
    async (accessToken, refreshToken, profile, done) => {
      try {
        const email =
          profile.emails && profile.emails[0] ? profile.emails[0].value : null;
        let user = await await prisma.user.findUnique({
          where: { email },
        });

        if (!user) {
          const userData = {
            facebookId: profile.id,
            firstName: profile.name.givenName,
            lastName: profile.name.familyName,
            email,
          };
          user = await userServices.createUser(userData);
        }

        return done(null, user);
      } catch (err) {
        return done(err);
      }
    },
  ),
);

passport.serializeUser((user, done) => {
  done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
  try {
    const user = await userServices.getUserById(id);
    done(null, user);
  } catch (err) {
    done(err);
  }
});
