import passport from 'passport';
import userServices from '../services/userServices.js';
import googleStrategy from './passport-google.js';
import facebookStrategy from './passport-facebook.js';
import localStrategy from './passport-local.js';

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

localStrategy(passport);
googleStrategy(passport);
facebookStrategy(passport);

export const verifyAuthentication = (req, res, next) => {
  if (req.isAuthenticated()) {
    return next();
  }
  res.status(401).json({ message: 'Authentication missing or expired' });
};

export const sendAuthStatus = (req, res) => {
  if (req.isAuthenticated()) {
    res.status(200).json({
      message: `Authenticated as user ${req.user.firstName} ${req.user.lastName}`,
    });
  } else {
    res.status(401).json({ message: 'Authentication missing or expired' });
  }
};

export const signin = (req, res) => {
  passport.authenticate('local', (error, user) => {
    if (error) {
      res.status(401).json({ message: `Authentication error: ${error}` });
    }
    req.login(user, (error) => {
      if (error) {
        res.status(500).json({ message: `Login error: ${error}` });
      }
      res.status(200).json({ message: 'Login successful' });
    });
  })(req, res);
};

export const signout = (req, res, next) => {
  const userId = req.user ? req.user.id : null;
  const userRole = req.user ? req.user.role : null;

  req.logout((error) => {
    if (error) {
      res.status(500).json({ message: `Logout error: ${error}` });
    }
    req.session.destroy((error) => {
      if (error) {
        res
          .status(500)
          .json({ message: `Session destruction error: ${error}` });
      }
      res.clearCookie('connect.sid');
      if (userRole === 'USER') {
        res.status(200).json({ message: 'Logout successful' });
      } else if (userRole === 'GUEST') {
        req.userId = userId;
        next();
      }
    });
  });
};

export default passport;
