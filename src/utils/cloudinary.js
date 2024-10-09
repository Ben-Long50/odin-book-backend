import { v2 as cloudinary } from 'cloudinary';

cloudinary.config({
  cloud_name: process.env.CLOUD_NAME,
  api_key: process.env.API_KEY,
  api_secret: process.env.API_SECRET,
  secure: true,
});

export const uploadToCloudinary = async (req, res, next) => {
  if (req.file) {
    try {
      const result = await cloudinary.uploader.upload(req.file.path);
      req.body.imageURL = result.secure_url;
    } catch (err) {
      console.error(err);
      res.status(500).json({
        success: false,
        message: 'Error uploading to Cloudinary',
      });
    }
  }
  next();
};

export default cloudinary;
