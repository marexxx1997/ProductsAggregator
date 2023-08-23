  document.addEventListener('DOMContentLoaded', function() {
    console.log(">>>>>>>>>>>>>>>>>>>>>");
    var modal = document.getElementById('candidatesModal');
    modal.addEventListener('show.bs.modal', function(event) {
      var button = event.relatedTarget; 
      var platformId = button.getAttribute('data-platform-id');
      var platformName = button.getAttribute('data-platform-name');
      var platformProductId = button.getAttribute('data-platform_product-id');

      console.log('Platform ID:', platformId);
      console.log('Platform Name:', platformName);
      console.log('Platform Product ID:', platformProductId);

      var approvedCandidateUrlInput = document.getElementById('approvedCandidateUrl');

      var xhr = new XMLHttpRequest();
      xhr.open('GET', '/candidates/' + platformId + '/' + platformProductId, true);
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.onload = function() {
        if (xhr.status === 200) {
          var candidates = JSON.parse(xhr.responseText);
          var tableBody = document.getElementById('candidatesTable').getElementsByTagName('tbody')[0];
          
          var approvedCandidate = candidates.find(function(candidate) {
            return candidate.selected === true;
          });

          if (approvedCandidate) {
            approvedCandidateUrlInput.value = approvedCandidate.url;
          } else {
            approvedCandidateUrlInput.value = 'No approved candidates';
          }

          tableBody.innerHTML = '';
          var cellsPerRow = 3;
          var row = null;

          candidates.forEach(function(candidate, index) {
            if (index % cellsPerRow === 0) {
                row = tableBody.insertRow();
              }
            var productCell = row.insertCell();
            productCell.classList.add("text-center", "border", "border-1");
            // productCell.innerHTML = '<h6 class="mb-3 candidate-heading-height">' + candidate.name + '</h6>' + '<img src="' + candidate.image_url + '" alt="' + candidate.name + '" height="200px" width="200px" class="align-self-center">' + 
            // '<br>' + '<button class="btn btn-success mt-3" data-candidate-id="' + candidate.id + '">Accept</button>';
            if (candidate.selected) {
              productCell.innerHTML = '<h6 class="mb-3 candidate-heading-height">' + candidate.name + '</h6>' + '<img src="' + candidate.image_url + '" alt="' + candidate.name + '" height="200px" width="200px" class="align-self-center">' + 
                '<br>' + '<button class="btn btn-approve fs-6 mt-3">Approved</button>';
            } else {
              productCell.innerHTML = '<h6 class="mb-3 candidate-heading-height">' + candidate.name + '</h6>' + '<img src="' + candidate.image_url + '" alt="' + candidate.name + '" height="200px" width="200px" class="align-self-center">' + 
                '<br>' + '<button class="btn btn-success mt-3" data-candidate-id="' + candidate.id + '">Accept</button>';
            }
          });
          var acceptButtons = document.querySelectorAll('.btn-success[data-candidate-id]');
          acceptButtons.forEach(function(acceptButton) {
            acceptButton.addEventListener('click', function() {
              var candidateId = this.getAttribute('data-candidate-id'); 
              var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
              console.log(">>>>>>>>>>>>>>>>>>>>>")
              console.log(candidateId)
              var updateStatusXhr = new XMLHttpRequest();
              updateStatusXhr.open('POST', '/platformproducts/update_platform_product_status', true);
              updateStatusXhr.setRequestHeader('Content-Type', 'application/json');
              updateStatusXhr.setRequestHeader('X-CSRF-Token', csrfToken);
              updateStatusXhr.send(JSON.stringify({ candidate_id: candidateId }));

              modal.hide();
          });
        });
        }
      };
      xhr.send();
    });
  });


  