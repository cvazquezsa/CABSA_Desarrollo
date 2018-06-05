[Forma]
Clave=ExplorarDocRama
Nombre=<T>Documentación - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=374
PosicionInicialAncho=279
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=372
PosicionInicialArriba=193
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=347

[Lista]
Estilo=Hoja
Clave=Lista
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
ListaEnCaptura=DocRama.Documento
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
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
ColorFuente=Negro

[Lista.Columnas]
Documento=250
Orden=35

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

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
Expresion=Asigna(Info.DocOk, Falso)<BR>Asigna(Info.Doc, DocRama:DocRama.Documento)<BR>Caso Info.Rama<BR>  Es <T>INV<T> Entonces Forma(<T>ArtDoc<T>)<BR>  Es <T>CXC<T> Entonces Forma(<T>CteDoc<T>)<BR>  Es <T>CXP<T> Entonces Forma(<T>ProvDoc<T>)<BR>  Es <T>DIN<T> Entonces Forma(<T>CtaDineroDoc<T>)<BR>  Es <T>ALM<T> Entonces Forma(<T>AlmDoc<T>)<BR>  Es <T>AGENT<T> Entonces Forma(<T>AgenteDoc<T>)<BR>  Es <T>RH<T>  Entonces Forma(<T>PersonalDoc<T>)<BR>  Es <T>CONT<T> Entonces Forma(<T>CtaDoc<T>)<BR>  Es <T>VIN<T> Entonces Forma(<T>VINDoc<T>)<BR>Fin

[Acciones.DocOk]
Nombre=DocOk
Boton=59
NombreEnBoton=S
NombreDesplegar=&Ok
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.DocOk, Verdadero)<BR>Asigna(Info.Doc, DocRama:DocRama.Documento)<BR>Caso Info.Rama<BR>  Es <T>INV<T> Entonces Forma(<T>ArtDoc<T>)<BR>  Es <T>CXC<T> Entonces Forma(<T>CteDoc<T>)<BR>  Es <T>CXP<T> Entonces Forma(<T>ProvDoc<T>)<BR>  Es <T>DIN<T> Entonces Forma(<T>CtaDineroDoc<T>)<BR>  Es <T>ALM<T> Entonces Forma(<T>AlmDoc<T>)<BR>  Es <T>AGENT<T> Entonces Forma(<T>AgenteDoc<T>)<BR>  Es <T>RH<T>  Entonces Forma(<T>PersonalDoc<T>)<BR>  Es <T>CONT<T> Entonces Forma(<T>CtaDoc<T>)<BR>  Es <T>VIN<T> Entonces Forma(<T>VINDoc<T>)<BR>Fin

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=DocFaltante
DocFaltante=DocOk
DocOk=(Fin)

[Lista.ListaOrden]
(Inicio)=DocRama.Orden<TAB>(Acendente)
DocRama.Orden<TAB>(Acendente)=DocRama.Documento<TAB>(Acendente)
DocRama.Documento<TAB>(Acendente)=(Fin)
