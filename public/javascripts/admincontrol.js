function admin_post_data(uri, data) {
  axios.post(uri, data)
  .then(function (response) {
    console.log("posted: ", response);
    document.getElementById("console").innerHTML = JSON.stringify(response.data);
  })
  .catch(function (error) {
    console.log(error);
  });
}

function admin_control() {
  var formElements=document.getElementById("new_user_form").elements;
  var postData={};
  postData["op"]="add_new_user";
  postData["privilage"]="admin";
  for (var i=0; i<formElements.length; i++){
    if (formElements[i].type!="submit"){
      postData[formElements[i].name]=formElements[i].value;
    }
  }
  console.log('new user created');
  console.log(postData);
  admin_post_data('/api', postData);

}
