%%%-------------------------------------------------------------------
%%% @author Carlos Varela <carlos.varela.paz@gmail.com>
%%% @copyright (C) 2011, Carlos Varela
%%% @doc
%%%
%%% @end
%%% Created : 18 Apr 2011 by Carlos Varela <carlos.varela.paz@gmail.com>
%%%-------------------------------------------------------------------
-module(ecbreak_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the supervisor
%%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end
%%--------------------------------------------------------------------
-spec start_link() -> {ok, pid()} | ignore | {error, {already_started, pid()} | shutdown | term()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================
%%--------------------------------------------------------------------
%% @private
%% @doc
%% Whenever a supervisor is started using supervisor:start_link/[2,3],
%% this function is called by the new process to find out about
%% restart strategy, maximum restart frequency and child
%% specifications.
%%
%% @spec init(Args) -> {ok, {SupFlags, [ChildSpec]}} |
%%                     ignore |
%%                     {error, Reason}
%% @end
%%--------------------------------------------------------------------
-spec init([]) -> {ok, { {one_for_one, 5, 10}, [?CHILD(ecbreak, worker)]} }.
init([]) ->
    {ok, { {one_for_one, 5, 10}, [?CHILD(ecbreak, worker)]} }.


