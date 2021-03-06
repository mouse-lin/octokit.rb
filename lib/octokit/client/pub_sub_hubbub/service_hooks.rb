module Octokit
  class Client
    module PubSubHubbub
      module ServiceHooks
        # Subscribe to a repository through pubsub
        #
        # @param repo [String, Repository, Hash] A GitHub repository
        # @param service_name [String] service name owner
        # @param service_arguments [Hash] params that will be passed by subscribed hook.
        #    List of services is available @ https://github.com/github/github-services/tree/master/docs.
        #    Please refer Data node for complete list of arguments.
        # @example Subscribe to push events to one of your repositories to Travis-CI
        #    client = Octokit::Client.new(:oauth_token = "token")
        #    client.subscribe_service_hook('joshk/device_imapable', 'Travis', { :token => "test", :domain => "domain", :user => "user" })
        def subscribe_service_hook(repo, service_name, service_arguments = {})
          topic = "#{Octokit.web_endpoint}#{Repository.new(repo)}/events/push"
          callback = "github://#{service_name}?#{service_arguments.collect{ |k,v| [ k,v ].join("=") }.join("&") }"
          subscribe(topic, callback)
        end

        # Unsubscribe repository through pubsub
        #
        # @param repo [String, Repository, Hash] A GitHub repository
        # @param service_name [String] service name owner
        #    List of services is available @ https://github.com/github/github-services/tree/master/docs.
        # @example Subscribe to push events to one of your repositories to Travis-CI
        #    client = Octokit::Client.new(:oauth_token = "token")
        #    client.unsubscribe_service_hook('joshk/device_imapable', 'Travis')
        def unsubscribe_service_hook(repo, service_name)
          topic = "#{Octokit.web_endpoint}#{Repository.new(repo)}/events/push"
          callback = "github://#{service_name}"
          unsubscribe(topic, callback)
        end
      end
    end
  end
end
