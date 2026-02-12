import os
import time
import graphviz

log_file_path = 'forks.log'

def update_graph():
    global dot
    dot = graphviz.Digraph(comment='Forks')
    
    with open(log_file_path, 'r') as file:
        lines = file.readlines()
    
    for line in lines:
        if line.strip():
            parts = line.split()
            parent = parts[1]
            child = parts[3]
            dot.node(parent, f'Parent {parent}')
            dot.node(child, f'Me {child}')
            dot.edge(parent, child)
            
    output_filename = 'forks_graph'
    dot.render(output_filename, format='png')
    print(f"Graph updated and saved as {output_filename}.png")

def monitor_log():
    if not os.path.exists(log_file_path):
        print(f"No log file found at {log_file_path}")
        return
    
    last_size = os.path.getsize(log_file_path)
    while True:
        update_graph()
        time.sleep(3)

if __name__ == "__main__":
    monitor_log()
