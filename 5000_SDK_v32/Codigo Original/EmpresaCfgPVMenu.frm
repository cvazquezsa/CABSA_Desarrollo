[Forma]
Clave=EmpresaCfgPVMenu
Nombre=Menú Alterno
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=203
PosicionInicialArriba=173
PosicionInicialAlturaCliente=388
PosicionInicialAncho=617
PosicionColumna1=26
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSeccion1=22

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgPVMenu
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=EmpresaCfgPVMenu.Tecla
HojaMantenerSeleccion=S

[Lista.EmpresaCfgPVMenu.Tecla]
Carpeta=Lista
Clave=EmpresaCfgPVMenu.Tecla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tecla=125
Nombre=156

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EmpresaCfgPVMenu
Fuente={Tahoma, 8, Negro, []}
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.EmpresaCfgPVMenu.Tecla]
Carpeta=Ficha
Clave=EmpresaCfgPVMenu.Tecla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.EmpresaCfgPVMenu.Nombre]
Carpeta=Ficha
Clave=EmpresaCfgPVMenu.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Ficha.EmpresaCfgPVMenu.NivelAcceso]
Carpeta=Ficha
Clave=EmpresaCfgPVMenu.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Expresion]
Estilo=Ficha
PestanaNombre=Expresión
Clave=Expresion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EmpresaCfgPVMenu
ConFuenteEspecial=S
Fuente={Fixedsys, 9, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=EmpresaCfgPVMenu.Expresion
CarpetaVisible=S
AlinearTodaCarpeta=S
Pestana=S
PestanaOtroNombre=S

[Expresion.EmpresaCfgPVMenu.Expresion]
Carpeta=Expresion
Clave=EmpresaCfgPVMenu.Expresion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.ExpresionesPV]
Nombre=ExpresionesPV
Boton=101
NombreEnBoton=S
NombreDesplegar=E&xpresiones PV
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Dialogos
ClaveAccion=ExpresionesPV
Activo=S
Visible=S



[Ficha.ListaEnCaptura]
(Inicio)=EmpresaCfgPVMenu.Tecla
EmpresaCfgPVMenu.Tecla=EmpresaCfgPVMenu.Nombre
EmpresaCfgPVMenu.Nombre=EmpresaCfgPVMenu.NivelAcceso
EmpresaCfgPVMenu.NivelAcceso=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Expresion
Expresion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=ExpresionesPV
ExpresionesPV=(Fin)
