
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

/*
	books an itinerary, pulling it off the market 
	expected parameters:
		itinID: string ID of the itineraryß
		isBooked: boolean whether the itinerary is booked
		isPaid: boolean whether the itenerary is paid
*/
Parse.Cloud.define("bookItinerary", function(request, response){
	var query = new Parse.Query("Itinerary");
	var user = Parse.User.current();

	if (request.params.itinID) {
		query.equalTo("objectId", request.params.itinID);
		query.first({
			success: function(result) {
				result.set("isBooked", request.params.isBooked);
				result.set("isPaid", request.params.isPaid);
				if (user) { //test this
					var guestRelation = result.relation("Guest");
					guestRelation.add(user);
					var itinRelation = user.relation("bookedItinerary");
					itinRelation.add(result);
				}
				result.save();
				response.success();
			},
			error: function() {
				response.error("ERROR: could not find itin");
			}
		});
	};
});