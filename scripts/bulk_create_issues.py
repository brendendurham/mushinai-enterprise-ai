import csv
import os
import asyncio
import aiohttp

GITHUB_API = "https://api.github.com"
REPO = os.environ.get("GITHUB_REPOSITORY")  # e.g., 'owner/repo'
TOKEN = os.environ.get("GITHUB_TOKEN")

if not REPO:
    raise EnvironmentError("GITHUB_REPOSITORY not set")
if not TOKEN:
    raise EnvironmentError("GITHUB_TOKEN not set")

HEADERS = {
    "Authorization": f"Bearer {TOKEN}",
    "Accept": "application/vnd.github+json",
}

async def create_issue(session, title, body, labels):
    url = f"{GITHUB_API}/repos/{REPO}/issues"
    payload = {"title": title, "body": body, "labels": labels.split(',') if labels else []}
    async with session.post(url, json=payload, headers=HEADERS) as resp:
        if resp.status != 201:
            text = await resp.text()
            raise RuntimeError(f"Failed to create issue {title}: {resp.status} {text}")
        data = await resp.json()
        print(f"Created issue #{data['number']}: {title}")

async def main(csv_path):
    async with aiohttp.ClientSession() as session:
        tasks = []
        with open(csv_path, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                tasks.append(create_issue(session, row['title'], row['body'], row.get('labels', '')))
        await asyncio.gather(*tasks)

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Bulk create GitHub issues in parallel.")
    parser.add_argument('csv', help='CSV file with columns: title, body, labels')
    args = parser.parse_args()
    asyncio.run(main(args.csv))
