
[Forma]
Clave=NOIPuestos
Icono=0
CarpetaPrincipal=NOIPuestos
Modulos=(Todos)
Nombre=Importar Puestos


ListaCarpetas=NOIPuestos
PosicionInicialAlturaCliente=450
PosicionInicialAncho=820
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=390
PosicionInicialArriba=186

[NOIDepartamento.ListaEnCaptura]
(Inicio)=NOIDepartamento.Departamento
NOIDepartamento.Departamento=NOIDepartamento.Sucursal
NOIDepartamento.Sucursal=NOIDepartamento.Ok
NOIDepartamento.Ok=NOIDepartamento.OkRef
NOIDepartamento.OkRef=(Fin)





[NOIDepartamento.Columnas]
Departamento=304
Sucursal=64
Ok=64
OkRef=198

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S

[NOIPuestos]
Estilo=Hoja
Clave=NOIPuestos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOIPuestos
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=NOIPuestos.Estacion ={EstacionTrabajo}
[NOIPuestos.NOIPuestos.Puesto]
Carpeta=NOIPuestos
Clave=NOIPuestos.Puesto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOIPuestos.NOIPuestos.SueldoRangoMinimo]
Carpeta=NOIPuestos
Clave=NOIPuestos.SueldoRangoMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOIPuestos.NOIPuestos.SueldoRangoMaximo]
Carpeta=NOIPuestos
Clave=NOIPuestos.SueldoRangoMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[NOIPuestos.Columnas]
Puesto=304
SueldoRangoMinimo=105
SueldoRangoMaximo=109
Ok=64
OkRef=193




[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)





[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Sugerir]
Nombre=Sugerir
Boton=92
NombreEnBoton=S
NombreDesplegar=Sugerir
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S


EspacioPrevio=S
Expresion=EjecutarSQL(<T>spNOIImportarPuestos:tEmpresa,:nEstacion<T>,Empresa,EstacionTrabajo)<BR>ActualizarForma
[Acciones.Importar]
Nombre=Importar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Importar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S





EspacioPrevio=S




























ConfirmarAntes=S
DialogoMensaje=NOIEstaSeguroCat
Expresion=ProcesarSQL(<T>spNOIGenerarPuestos:tEmpresa,:nEstacion<T>,Empresa,EstacionTrabajo)<BR>ActualizarForma







[NOIPuestos.ListaEnCaptura]
(Inicio)=NOIPuestos.Puesto
NOIPuestos.Puesto=NOIPuestos.SueldoRangoMinimo
NOIPuestos.SueldoRangoMinimo=NOIPuestos.SueldoRangoMaximo
NOIPuestos.SueldoRangoMaximo=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Sugerir
Sugerir=Importar
Importar=(Fin)
