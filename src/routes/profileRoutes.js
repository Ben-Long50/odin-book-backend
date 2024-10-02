import express from 'express';
import cors from 'cors';
import profileController from '../controllers/profileController.js';
import { verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.post(
  '/profile',
  cors({
    origin: 'http://localhost:5173',
    credentials: true,
  }),
  verifyAuthentication,
  profileController.createProfile,
);

router.get(
  '/profiles',
  cors({
    origin: 'http://localhost:5173',
    credentials: true,
  }),
  verifyAuthentication,
  profileController.getProfiles,
);

export default router;
