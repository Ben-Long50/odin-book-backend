import { Strategy as GoogleStrategy } from 'passport-google-oauth20';
import userServices from '../services/userServices.js';
import prisma from '../config/database.js';
import profileServices from '../services/profileServices.js';

const googleStrategy = (passport) => {
  passport.use(
    new GoogleStrategy(
      {
        clientID: process.env.GOOGLE_ID,
        clientSecret: process.env.GOOGLE_SECRET,
        callbackURL: `${process.env.API_URL}/auth/google/callback`,
        scope: ['profile', 'email'],
        state: true,
      },
      async (accessToken, refreshToken, profile, done) => {
        try {
          const email =
            profile.emails && profile.emails[0]
              ? profile.emails[0].value
              : null;
          const [firstName, lastName] = profile.displayName.split(' ');
          let user = await prisma.user.findUnique({
            where: { email },
          });
          if (user) {
            if (user.googleId !== profile.id) {
              return done(null, false);
            }
          } else {
            const userData = {
              googleId: profile.id,
              firstName,
              lastName,
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

export default googleStrategy;
