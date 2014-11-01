
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
	}
});

/*
	Returns all the relevant events for the user, locaiton and time
	expected parameters:
		rangeStart: date of earliest date the user is considering tour
		rangeEnd: date of latest date the user is considering tour
		location: location of the desired area.
*/
Parse.Cloud.define("getItineraries", function(request, response){
	var user = Parse.User.current();
	var query = new Parse.Query("Itinerary");

	if (request.params.location && request.params.rangeStart && request.params.rangeEnd) {
		query.near("location", request.params.location);
		query.limit(10);
		query.lessThan("endTime",request.params.rangeEnd);
		query.greaterThan("startTime",request.params.rangeStart);
		query.find({
			success: function(results) {
				response.success(results);
			},
			error: function() {
				response.error("ERROR: could not find itin");
			}
		});
	}
})