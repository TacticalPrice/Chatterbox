const Group = require('../models/Group');
const Message = require('../models/Message');

exports.createGroup = async (req,res) => {
    try{
        const { name , members } = req.body;
        const newGroup = new Group({ name, members });
        await newGroup.save();
        res.status(201).json(newGroup);
    }catch(e){
        console.error(e);
        res.status(500).json({message : 'Server Error'});
    }
};

exports.sendGroupMessage = async (req ,res) => {
    try{
        const { sender, group, content } = req.body;
        const newMessage = new Message({ sender, group, content});
        await newMessage.save();
        res.status(201).json({message: 'Message sent successfully'});
    }catch(e){
        console.error(e);
        res.status(500).json({message: 'Server Error'});
    }
}

exports.getGroupMessages = async (req,res) => {
    try{
        const groupId = req.params.groupId;
        const message = await Message.find({group : groupId}).populate('sender', 'email');
        res.json(messages);
    }catch(e){
        console.error(e);
        res.status(500).json({message: 'Server Error'});
    }
};