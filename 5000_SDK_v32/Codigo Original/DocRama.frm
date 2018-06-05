[Forma]
Clave=DocRama
Nombre=e(<T>Documentación<T>)+<T> - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=374
PosicionInicialAncho=423
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=300
PosicionInicialArriba=197
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DocRama
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=DocRama.Rama=<T>{Info.Rama}<T>
[Lista.DocRama.Documento]
Carpeta=Lista
Clave=DocRama.Documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[Lista.Columnas]
Documento=214
Orden=35
Grupo=143

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.DocRama.Orden]
Carpeta=Lista
Clave=DocRama.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.DocFaltante]
Nombre=DocFaltante
Boton=58
NombreDesplegar=&Faltantes
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S

Expresion=Asigna(Info.DocOk, Falso)<BR>Asigna(Info.Doc, DocRama:DocRama.Documento)<BR>Caso Info.Rama<BR>  Es <T>INV<T> Entonces Forma(<T>ArtDoc<T>)<BR>  Es <T>CXC<T> Entonces Forma(<T>CteDoc<T>)<BR>  Es <T>CXP<T> Entonces Forma(<T>ProvDoc<T>)<BR>  Es <T>DIN<T> Entonces Forma(<T>CtaDineroDoc<T>)<BR>  Es <T>ALM<T> Entonces Forma(<T>AlmDoc<T>)<BR>  Es <T>AGENT<T> Entonces Forma(<T>AgenteDoc<T>)<BR>  Es <T>RH<T>  Entonces Forma(<T>PersonalDoc<T>)<BR>  Es <T>CONT<T> Entonces Forma(<T>CtaDoc<T>)<BR>  Es <T>VIN<T> Entonces Forma(<T>VINDoc<T>)<BR>  Es <T>OPORT<T> Entonces Forma(<T>OportunidadPlantillaDoc<T>)<BR>Fin
[Acciones.DocOk]
Nombre=DocOk
Boton=59
NombreEnBoton=S
NombreDesplegar=&Ok
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.DocOk, Verdadero)<BR>Asigna(Info.Doc, DocRama:DocRama.Documento)<BR>Caso Info.Rama<BR>  Es <T>INV<T> Entonces Forma(<T>ArtDoc<T>)<BR>  Es <T>CXC<T> Entonces Forma(<T>CteDoc<T>)<BR>  Es <T>CXP<T> Entonces Forma(<T>ProvDoc<T>)<BR>  Es <T>DIN<T> Entonces Forma(<T>CtaDineroDoc<T>)<BR>  Es <T>ALM<T> Entonces Forma(<T>AlmDoc<T>)<BR>  Es <T>AGENT<T> Entonces Forma(<T>AgenteDoc<T>)<BR>  Es <T>RH<T>  Entonces Forma(<T>PersonalDoc<T>)<BR>  Es <T>CONT<T> Entonces Forma(<T>CtaDoc<T>)<BR>  Es <T>VIN<T> Entonces Forma(<T>VINDoc<T>)<BR>  Es <T>OPORT<T> Entonces Forma(<T>OportunidadPlantillaDoc<T>)<BR>Fin
[Lista.DocRama.Grupo]
Carpeta=Lista
Clave=DocRama.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=DocRama.Documento
DocRama.Documento=DocRama.Grupo
DocRama.Grupo=DocRama.Orden
DocRama.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=DocRama.Grupo	(Acendente)
DocRama.Grupo	(Acendente)=DocRama.Orden	(Acendente)
DocRama.Orden	(Acendente)=DocRama.Documento	(Acendente)
DocRama.Documento	(Acendente)=(Fin)



















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=DocFaltante
DocFaltante=DocOk
DocOk=(Fin)
