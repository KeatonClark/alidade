import csv, os, sys

path = sys.argv[1]

rows = []
has_errors = False

with open(path) as f:
    for row in csv.DictReader(f):
        if row["Excluded"].strip().lower() == "true":
            continue
        sev = row["Severity"].strip().lower()
        if sev == "error":
            has_errors = True
        cmd   = "error" if sev == "error" else "warning"
        chk   = row["Check"].strip()
        typ   = row["Type"].strip().replace("%", "%25").replace("\n", "%0A")
        desc  = row["Description"].strip().replace("%", "%25").replace("\n", "%0A")
        det   = row["Details"].strip().replace("%", "%25").replace("\n", "%0A")
        print(f"::{cmd} title={typ}::{chk} — {desc}: {det}")
        rows.append(row)

summary = os.environ.get("GITHUB_STEP_SUMMARY", "")
if summary:
    errs  = [r for r in rows if r["Severity"].lower() == "error"]
    warns = [r for r in rows if r["Severity"].lower() == "warning"]
    with open(summary, "a") as f:
        if has_errors:
            status = "errors found"
        elif warns:
            status = "warnings only"
        else:
            status = "clean"
        f.write(f"## ERC results — {status}\n\n")
        f.write(f"{len(errs)} error(s), {len(warns)} warning(s)\n\n")
        if rows:
            f.write("| Check | Severity | Type | Description | Details |\n")
            f.write("|-------|----------|------|-------------|---------|\n")
            for r in rows:
                f.write(f"| {r['Check']} | {r['Severity']} | {r['Type']} | {r['Description']} | {r['Details']} |\n")
        else:
            f.write("No issues found.\n")

sys.exit(1 if has_errors else 0)
