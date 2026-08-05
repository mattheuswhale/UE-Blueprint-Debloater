# UE Blueprint Debloater

A local Flask web app that converts Unreal Engine Blueprint clipboard serialization into compact, LLM-readable graph text.

## Run on Windows

1. Extract the folder.
2. Double-click `run.bat`.
3. Open `http://127.0.0.1:5000` if the browser does not open automatically.
4. Paste copied Blueprint nodes, choose a mode, and click **Debloat**.

The first launch creates a local `.venv` and installs Flask.

## Manual start

```powershell
py -m venv .venv
.venv\Scripts\activate
python -m pip install -r requirements.txt
python ue_blueprint_debloater.py
```

## Modes

- **Compact**: keeps linked pins, user-defined pins, meaningful input defaults, semantic node properties, and graph connections. Removes unconnected boilerplate such as `self`, output delegates, unused `then` pins, GUIDs, positions, export paths, and repeated pin flags.
- **Conservative**: also includes unconnected visible pins.

## Example result

```text
BLUEPRINT GRAPH
nodes: 2
mode: compact

NODES
K2Node_CustomEvent_8: CustomEvent "Set TurnRate BluePrint"
  rpc: Server, Unreliable
  flags: Public, BlueprintCallable, BlueprintEvent
  outputs: then:exec, Turn:double
K2Node_CallFunction_0: CallFunction "Set Turnrate Test Node Blueprint"
  target: self
  inputs: execute:exec, Turn:double

CONNECTIONS
K2Node_CustomEvent_8.then -> K2Node_CallFunction_0.execute
K2Node_CustomEvent_8.Turn -> K2Node_CallFunction_0.Turn
```

## Current limitations

- This is a parser for the text Unreal currently places on the clipboard, not a full `.uasset` parser.
- Unusual or newly introduced node properties may need to be added to `SEMANTIC_PROPERTIES`.
- Links to nodes outside the copied selection cannot always resolve the remote pin name; the output retains a shortened pin identifier instead.
- The program does not call an LLM or generate C++ itself. It only creates clean plain text for pasting into an LLM.
