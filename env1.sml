(*
 *[EXCEPTION] NameNotBound of string
 * An exception that is raised when a string is not not bound to a value in the
 * given Environment. 
 *)
exception NameNotBound of string;

(*
 *[TYPE] Env = (string*int) list
 * Env represents an environment. A closure that maps a string to an integer.
 * This is a list of (string,int) pairs.
 *)
type Env = (string*int) list;

(*
 *[FUNCTION] env_new = fn : unit -> Env
 * Returns a new Env.
 * Note that new Envs don't have any mappings, and thus are just empty lists.
 * Argument must be the unit value.
 *)
fun env_new () : Env  = nil;

(*
 *[FUNCTION] env_bind = fn : Env -> string -> int -> Env
 * Adds the given name and value mapping into the given Env. Note that
 * such dynamic building is only possible by creating a new Env.
 * Arguments must be an Env, a string, and an integer.
 *)
fun env_bind (nil:Env) name value : Env = [(name,value)] 
(*the above case is already included in the below case*)
  | env_bind (env:Env) name value : Env = (name,value)::env
;

(*
 *[FUNCTION] env_lookup = fn : Env -> string -> int
 * Returns the value associated with the given name in the given Env. A
 * NameNotBound is thrown if the name is not bound in the Env.
 * Arguments must be an Env and a string.
 *)
fun env_lookup (nil:Env) name =  raise NameNotBound "NameNotBound"
  | env_lookup (env:Env) name =
  (*Alternative: env_lookup ((n,value)::rest) name*)
    let val headName = #1 (hd env)
	val headValue = #2 (hd env)
	val envTail : Env = tl env
    in if headName = name
       then headValue
       else env_lookup envTail name (*this is in tail position*)
    end;
