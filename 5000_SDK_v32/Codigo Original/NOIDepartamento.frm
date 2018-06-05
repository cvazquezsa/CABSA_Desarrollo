
[Forma]
Clave=NOIDepartamento
Icono=0
CarpetaPrincipal=NOIDepartamento
Modulos=(Todos)
Nombre=Importar Departamentos

ListaCarpetas=NOIDepartamento
PosicionInicialAlturaCliente=362
PosicionInicialAncho=680
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=460
PosicionInicialArriba=230
[NOIDepartamento]
Estilo=Hoja
Clave=NOIDepartamento
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOIDepartamento
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
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=NOIDepartamento.Estacion = {EstacionTrabajo}
[NOIDepartamento.NOIDepartamento.Departamento]
Carpeta=NOIDepartamento
Clave=NOIDepartamento.Departamento
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOIDepartamento.NOIDepartamento.Sucursal]
Carpeta=NOIDepartamento
Clave=NOIDepartamento.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



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
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S







[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)








[Acciones.Importar]
Nombre=Importar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Importar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S


EspacioPrevio=S
GuardarAntes=S
ConfirmarAntes=S
DialogoMensaje=NOIEstaSeguroCat
Expresion=ProcesarSQL(<T>spNOIGenerarDepartamento:tEmpresa,:nEstacion<T>,Empresa,EstacionTrabajo)<BR>ActualizarForma
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












Expresion=EjecutarSQL(<T>spNOIImportarDepartamento :tEmpresa,:nEstacion<T>,Empresa,EstacionTrabajo)<BR>ActualizarForma













[Lista.Columnas]
0=91
1=267





[NOIDepartamento.ListaEnCaptura]
(Inicio)=NOIDepartamento.Departamento
NOIDepartamento.Departamento=NOIDepartamento.Sucursal
NOIDepartamento.Sucursal=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=Sugerir
Sugerir=Importar
Importar=(Fin)
