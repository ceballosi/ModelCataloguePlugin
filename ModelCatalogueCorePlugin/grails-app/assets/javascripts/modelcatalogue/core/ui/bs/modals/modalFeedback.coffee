angular.module('mc.core.ui.bs.modalFeedback', ['mc.util.messages']).config (messagesProvider)->
 messagesProvider.setPromptFactory 'feedback', ($modal) ->
   "ngInject"
   (title, body, args) ->
      dialog = $modal.open {
        windowClass: 'messages-modal-feedback'
        size: 'lg'
        template: '''
         <div class="modal-header">
                <div class="catalogue-element-detail-actions">
                  <contextual-actions icon-only="true" role="feedback" size="xs" no-colors="true"></contextual-actions>
                </div>
            <h4>{{ feedback.name }}</h4>
        </div>
        <div class="modal-body">
            <div class="row">
              <div class="col-lg-12 col-sm-12 col-md-12">
                  <pre>{{ feedback.log || 'Nothing logged yet or the log entry has expired after 24 hours of inactivity'}}</pre>
              </div>
          </div>
        </div>
        <div class="modal-footer">
          <form role="form">
            <button class="btn btn-default" ng-click="open()"><span class="fa fa-fw fa-external-link"></span> Open in Separate Page</button>
            <button class="btn btn-primary" ng-click="$close(true)">OK</button>
            <button class="btn btn-warning" ng-click="$dismiss(false)">Close</button>
          </form>
        </div>
        '''
        resolve:
          feedback: ($http, modelCatalogueApiRoot, MessagingClient) ->
            $http.get("#{modelCatalogueApiRoot}/feedback/#{args.id}").then (result) ->
              feedback = result.data
              MessagingClient.subscribe "/topic/feedback/#{args.id}/lines", (message) ->
                 feedback.log = feedback.log + '\n' +  JSON.parse(message.body)?.lines
              feedback

        controller: ($scope, feedback, $state, $window) ->
          $scope.feedback = feedback

          $scope.open = ->
            $window.open($state.href('simple.feedback', {id: args.id}), '_blank')
            return
      }


      dialog.result
