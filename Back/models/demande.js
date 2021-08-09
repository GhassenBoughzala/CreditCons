var mongoose = require("mongoose")
var Schema = mongoose.Schema

var demandeSchema = new Schema({

  type: String,
  apport: Number,
  montant: Number,
  resultat: Number,
  duree: Number,
  period: String,
  date: {
    type: Date,
    default: Date.now,
  },

  user: {
    type: Schema.Types.ObjectId,
    ref: "user",
  }
});

module.exports = mongoose.model('demande', demandeSchema);
