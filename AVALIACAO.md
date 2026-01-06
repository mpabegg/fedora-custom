# Avaliacao detalhada do projeto (repo vs descricao)

Este documento consolida o estado atual do repo, valida a descricao fornecida e registra gaps/sugestoes. A ideia e que ele sirva como fonte de contexto se a conversa for retomada.

## 1) Escopo declarado pelo usuario (resumo)

- Base: Fedora KDE Atomic (rpm-ostree), Wayland default, KDE stock.
- Host minimalista: sistema base + QoL. Desenvolvimento e tooling em Distrobox.
- Atualizacoes via rpm-ostree e rollback funcional.
- Flatpaks system-wide via BlueBuild com Flathub e Fedora remote removido.
- Servicos no host: 1Password (GUI + CLI) e keyd (Caps Lock -> Escape).
- Shell/CLI QoL via `/etc/profile.d`:
  - Locale UTF-8, EDITOR/VISUAL, aliases neutros, prompt simples.
  - PATH do Homebrew configurado (brew nao instalado pelo sistema).
  - `ujust` estilo Bazzite.
  - Banner de boas-vindas removido.
- Metodologia de teste: VM limpa, rebase direto, sem herdar /var, pipeline BlueBuild ok.
- Fora do escopo (por design): NVIDIA, gamescope/SteamOS, tuning agressivo, tweaks avancados de audio.
- Proximos objetivos:
  - xpadneo + udev/firmware.
  - Sessao alternativa Wayland (ScrollWM + DankMaterialShell) mantendo KDE default.
  - ISO opcional depois de UX/hardware estabilizar.

## 2) Estado atual do repo (o que esta implementado)

### 2.1 Estrutura geral

- `recipes/recipe.yml`: definicao da imagem, base, modulos.
- `files/system/*`: arquivos copiados para o sistema.
- `files/scripts/example.sh`: exemplo (nao usado).
- `cosign.pub`: chave publica para verificacao de assinatura.
- `README.md`: ainda template do BlueBuild.

### 2.2 Base da imagem

- Base definida em `recipes/recipe.yml`:
  - `base-image: ghcr.io/ublue-os/kinoite-main`
  - `image-version: latest`
- Implicacao: KDE Atomic, alinhado a `kinoite-main` da uBlue.

### 2.3 Modulos BlueBuild configurados (ordem de execucao)

1) **files**
   - Copia `files/system/*` para `/` da imagem.

2) **dnf**
   - COPRs: `atim/starship`, `alternateved/keyd`.
   - Pacotes instalados:
     - `micro`
     - `starship`
     - `keyd`
     - `1password`
     - `1password-cli`

3) **default-flatpaks** (system)
   - Flathub adicionado (system scope).
   - Flatpaks instalados:
     - `com.brave.Browser`
     - `app.zen_browser.zen`
     - `com.valvesoftware.Steam`
     - `com.vysp3r.ProtonPlus`
     - `org.videolan.VLC`
     - `com.github.tchx84.Flatseal`

4) **systemd**
   - `keyd.service` habilitado (system).

5) **signing**
   - Configuracao de assinatura para imagem assinada.

### 2.4 Arquivos do host (files/system)

#### `/etc/profile.d` (QoL em shell)

- `files/system/etc/profile.d/10-locale-utf8.sh`
  - Define `LANG=C.UTF-8` quando `LANG` esta vazio.

- `files/system/etc/profile.d/20-editor-visual.sh`
  - Seleciona editor em ordem: `nvim`, `vim`, `vi`, `nano`.
  - Define `EDITOR` e `VISUAL` se nao estiverem setados.

- `files/system/etc/profile.d/30-linuxbrew-path.sh`
  - Se existir `/home/linuxbrew/.linuxbrew`, adiciona `bin` e `sbin` ao `PATH`.
  - Nao instala brew; apenas PATH idempotente.

- `files/system/etc/profile.d/40-host-aliases.sh`
  - Aliases simples: `ll`, `la`, `l`, `..`, `...`.

- `files/system/etc/profile.d/50-host-prompt.sh`
  - Prompt Bash simples: `\u@\h:\w\$`.

- `files/system/etc/profile.d/90-welcome-banner.sh`
  - Exibe "Welcome to <hostname>" para shells interativos.

#### Outros arquivos

- `files/system/usr/bin/ujust`
  - Wrapper: `just -f /usr/share/ublue-os/justfile`.

- `files/system/etc/keyd/default.conf`
  - Config default do keyd:
    - `capslock = overload(control, esc)`.
    - `102nd = layer(shift)`.

- `files/system/etc/yum.repos.d/1password.repo`
  - Repo oficial 1Password (stable), com `gpgcheck` e `repo_gpgcheck`.

## 3) Validacao da descricao vs repo (convergencias e divergencias)

### 3.1 Convergencias

- **Base KDE Atomic**: consistente com `kinoite-main`.
- **Flatpaks listados**: Brave, Zen, Steam, ProtonPlus, VLC, Flatseal presentes.
- **1Password**: repo e pacotes instalados no host.
- **Keyd**: instalado e `keyd.service` habilitado.
- **QoL via profile.d**: locale, editor, aliases e prompt simples estao presentes.
- **ujust**: wrapper equivalente ao Bazzite presente.

### 3.2 Divergencias ou lacunas

- **Banner removido**: o repo possui `90-welcome-banner.sh` mostrando banner.
- **Keyd (Caps Lock -> Esc)**: configurado como `overload(control, esc)`, nao estritamente apenas `Escape`.
- **Starship**: pacote instalado via COPR, mas voce mencionou prompt simples e sem temas (prompt simples existe, mas starship e um extra nao citado).
- **Micro**: pacote instalado e nao citado na descricao.
- **Remocao do remote Fedora (Flatpak)**: nao ha modulo/config explicitando remocao do remote Fedora.

## 4) Sugestoes e melhorias (com base em Bazzite/WayBlue)

Estas sugestoes sao alinhadas ao foco de host limpo, previsivel e compatibilidade.

### 4.1 Suporte a controles Xbox (Bazzite-like)

- **xpadneo** para Xbox One/Series via Bluetooth.
- **Firmware e regras udev** (se aplicavel), possivelmente em `files/system/etc/udev/rules.d/`.
- Avaliar tambem `xone` para dongle USB (se for requisito futuro).

### 4.2 Sessao Wayland alternativa (ScrollWM + DankMaterialShell)

- Objetivo: adicionar uma sessao adicional sem afetar KDE.
- Abordagem tipica:
  - Instalar pacotes/artefatos via `dnf` (ou outros modulos).
  - Criar `.desktop` em `/usr/share/wayland-sessions/` via `files/system`.
  - Manter KDE como default (nenhuma alteracao no SDDM alem de disponibilizar a sessao).

### 4.3 Distrobox QoL

- Se nao estiver no base, considerar adicionar:
  - `distrobox` + `podman`.
  - `ujust` ou script para criar containers padrao.
- Mantem o host limpo e delega tooling, alinhado ao objetivo.

### 4.4 Flatpak hygiene

- Se o requisito for "remover remote Fedora":
  - Adicionar modulo/etapa especifica no `recipes/recipe.yml` para remover o remote Fedora.
- Ajustar prioridade do Flathub se preciso.

### 4.5 Atualizacoes automaticas (opcional)

- Se desejar comportamento mais "set and forget":
  - `rpm-ostreed-automatic` com politica conservadora (se isso nao conflitar com controle manual).

### 4.6 Documentacao

- `README.md` ainda e template; atualizar para refletir:
  - Objetivos (host limpo + Distrobox).
  - Escopo atual e fora do escopo.
  - Instrucoes de rebase/rollback e validacao.
  - Lista de pacotes/Flatpaks e rationale.

## 5) Itens a confirmar/decidir

- **Banner**: deve ser removido mesmo? Se sim, remover `90-welcome-banner.sh`.
- **Keyd**: deseja realmente `Caps Lock -> Esc` puro ou prefere `overload(control, esc)`?
- **Starship**: manter ou remover do host?
- **Micro**: manter ou remover?
- **Remocao do remote Fedora**: confirmar requisito e forma preferida.
- **xpadneo**: apenas Bluetooth ou tambem suporte a dongle (`xone`)?
- **Sessao alternativa**: quais pacotes exatos de ScrollWM + DankMaterialShell (repos, build, etc).

## 6) Observacoes finais

- O repo mostra uma base consistente com a proposta (KDE Atomic + host enxuto + QoL via profile.d).
- Existem pequenos desvios entre a descricao e o que esta commitado.
- As proximas features podem ser adicionadas incrementalmente, mantendo o foco de previsibilidade.
