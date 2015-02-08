// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

//Function Definition:	changePassword(String Username, String OldPassword, String NewPassword)
//	Returns:	String -   "Password changed successfully" or "Change password failed"
Parse.Cloud.define("changePassword", function(request, response) {
	var query = new Parse.Query("_User");
	query.equalTo("username", request.params.Username);
	query.find({
	success: function(results) {
	  if(results.length > 0){
		results[0].password = request.params.NewPassword;
		results[0].save();
		response.success("Password changed successfully");
	  }
	  //response.success("3");
	},
	error: function() {
	  response.error("Change password failed");
	}
	});
});

Parse.Cloud.define("getUserGroups", function(request, response) {
	var query = new Parse.query("IsMemberOf");
	var userids = ["n"];
	var index;
	
	query.equalTo("username", request.params.userid);
	query.find({
		success: function(results) {
			for(index=0; index < results.length; index++) {
				userids[index] = results[index].groupId;
			}
			response.success(results);
		},
		error: function() {
			response.error("");
		}
	});
	
	
});

//Sample function not related to our project
//Function Definition:	getAllDeals()
//Returns:	ArrayList<ParseObject>
Parse.Cloud.define("getAllDeals", function(request, response) {
  var query = new Parse.Query("Deal");
  if(request.params.Category != "All"){
    query.equalTo("Category", request.params.Category);
  }
  //query.equalTo("movie", request.params.movie);
  query.find({
    success: function(results) {
      //var sum = 0;
      //for (var i = 0; i < results.length; ++i) {
      //  sum += results[i].get("stars");
      //}
      response.success(results);
      //response.success("3");
    },
    error: function() {
      response.error("No deals found");
    }
  });
});