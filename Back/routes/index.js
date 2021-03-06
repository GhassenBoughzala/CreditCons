const express = require('express')
const actions = require('../methods/actions')
const demactions = require('../methods/demandeactions')
const auth = require('../methods/authController')
const router = express.Router()

router.get('/', (req, res) => {
    res.send('Hello World')
})

router.get('/dashboard', (req, res) => {
    res.send('Dashboard')
})

//@desc Adding new user
//@route POST /adduser
router.post('/adduser', actions.addNew)

//@desc Authenticate a user
//@route POST /authenticate
router.post('/authenticate', actions.authenticate)

//@desc Get info on a user
//@route GET /getinfo
router.get('/getinfo', actions.getinfo)


//AuthUser 2.0
router.post('/signup', auth.signup)
router.post('/signin', auth.signin)
router.get('/logout', auth.logout)

//Demande CRUD
router.post('/addDem', demactions.addDem)
router.get('/viewall', demactions.viewAll)
router.put('/updateDem/:id', demactions.updateDem)
router.delete('/deleteDem/:id', demactions.annulerDem)

module.exports = router