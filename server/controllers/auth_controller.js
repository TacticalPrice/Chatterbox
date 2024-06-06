const User = require('../models/User');
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken');

exports.signup = async (req,res) => {
    try{
        const { email , password} = req.body;
        const existingUser = await User.findOne({ email });

        if(existingUser){
            return res.status(400).json({message : 'User already exists'});
        }

        const hashedPassword = await bcrypt.hash(password ,12);
        const newUser = new User({email , password: hashedPassword});
        await newUser.save();

        const token = jwt.sign({userId : newUser._id}, process.env.JWT_SECRET, {expiresIn: '1h'});
        res.status(201).json({token});
    }catch(e){
        console.error(e);
        res.status(500).json({message: 'Server Error'});
    }
};

exports.login = async (req, res) => {
    try {
      const { email, password } = req.body;
      const user = await User.findOne({ email });
  
      if (!user) {
        return res.status(401).json({ message: 'Invalid email or password' });
      }
  
      const isPasswordCorrect = await bcrypt.compare(password, user.password);
  
      if (!isPasswordCorrect) {
        return res.status(401).json({ message: 'Invalid email or password' });
      }
  
      const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });
      res.status(200).json({ token });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server Error' });
    }
  };