const Message = require('../models/Message');

exports.sendDM = async (req ,res) => {
    try{
        const { sender , recipient, content} = req.body;
        const newMessage = new Message({sender, recipient,content});
        await newMessage.save();
        res.status(201).json({message : "Message sent successfully"});
    }catch(e){
        console.error(e);
        res.status(500).json({message: 'Server Error'});
    }
};

exports.getDMs = async (req,res) => {
    try{
        const userId = req.userId;
        const messages = await Message.find({recipient: userId}).populate('sender','email');
        res.json(message);
    }catch(e){
        console.error(e);
        res.status(500).json({message : 'Server Error'});
    }
};