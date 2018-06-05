[Forma]
Clave=ProvLD
Nombre=<T>Lista de Proveedores - <T>+Info.Lista
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=254
PosicionInicialArriba=225
PosicionInicialAltura=311
PosicionInicialAncho=517
VentanaExclusiva=S
PosicionInicialAlturaCliente=284

[Lista]
Estilo=Hoja
Clave=Lista
ValidarCampos=
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProvLD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroGeneral=ProvLD.Rama = <T>CXP<T> AND<BR>ProvLD.Lista = <T>{Info.Lista}<T>
FiltroRespetar=S

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

[Lista.Columnas]
Proveedor=123
Grupo=85
Descripcion1=202
Nombre=202
Cuenta=124
SubGrupo=74

[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFuente=Gris

[Lista.ProvLD.Cuenta]
Carpeta=Lista
Clave=ProvLD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Lista.ProvLD.Grupo]
Carpeta=Lista
Clave=ProvLD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.ProvLD.SubGrupo]
Carpeta=Lista
Clave=ProvLD.SubGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Acciones.Positivo]
Nombre=Positivo
Boton=62
NombreDesplegar=Positivo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(ProvLD:ProvLD.Signo, <T>+<T>)

[Acciones.Negativo]
Nombre=Negativo
Boton=63
NombreDesplegar=Negativo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(ProvLD:ProvLD.Signo, <T>-<T>)

[Acciones.Grupo]
Nombre=Grupo
Boton=91
NombreEnBoton=S
NombreDesplegar=G&rupos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaGrupo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>CXP<T>)<BR>Asigna(Info.Descripcion, <T>Listas de Proveedores<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Grupo
Grupo=Positivo
Positivo=Negativo
Negativo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProvLD.Cuenta
ProvLD.Cuenta=Prov.Nombre
Prov.Nombre=ProvLD.Grupo
ProvLD.Grupo=ProvLD.SubGrupo
ProvLD.SubGrupo=(Fin)
