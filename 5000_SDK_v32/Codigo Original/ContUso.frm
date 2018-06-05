[Forma]
Clave=ContUso
Nombre=Usos Contables
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=201
PosicionInicialArriba=142
PosicionInicialAltura=484
PosicionInicialAncho=622
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=50
PosicionSeccion1=61

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContUso
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
PestanaNombre=Lista
HojaMantenerSeleccion=S

[Lista.ContUso.ContUso]
Carpeta=Lista
Clave=ContUso.ContUso
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContUso.Descripcion]
Carpeta=Lista
Clave=ContUso.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
ContUso=155
Descripcion=291
Cuenta=124
Descripcion_1=204
CentroCostos=95
Descripcion_2=225
Grupo=136

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Uso Contable
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContUso
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalle.ContUso.ContUso]
Carpeta=Detalle
Clave=ContUso.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ContUso.Descripcion]
Carpeta=Detalle
Clave=ContUso.Descripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ContUso.Cuenta]
Carpeta=Detalle
Clave=ContUso.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Cta.Descripcion]
Carpeta=Detalle
Clave=Cta.Descripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ContUso.CentroCostos]
Carpeta=Detalle
Clave=ContUso.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos.Descripcion]
Carpeta=Detalle
Clave=CentroCostos.Descripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ContUso.Grupo]
Carpeta=Detalle
Clave=ContUso.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.ContUso.Grupo]
Carpeta=Lista
Clave=ContUso.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

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
AntesExpresiones=Asigna(Info.Rama, <T>CONTU<T>)<BR>Asigna(Info.Descripcion, <T>Usos Contables<T>)
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Grupo
Grupo=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ContUso.ContUso
ContUso.ContUso=ContUso.Descripcion
ContUso.Descripcion=ContUso.Grupo
ContUso.Grupo=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=ContUso.ContUso
ContUso.ContUso=ContUso.Descripcion
ContUso.Descripcion=ContUso.Grupo
ContUso.Grupo=ContUso.Cuenta
ContUso.Cuenta=Cta.Descripcion
Cta.Descripcion=ContUso.CentroCostos
ContUso.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=(Fin)
