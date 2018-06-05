[Forma]
Clave=mcModuloMovPoliza
Nombre=Póliza del Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=635
PosicionInicialAncho=965
PosicionInicialIzquierda=477
PosicionInicialArriba=264
PosicionCol1=860
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Modulo, Info.Mov)
PosicionSec1=310
PosicionCol2=951
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=mcModuloMovPoliza
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
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaAjustarColumnas=S
FiltroGeneral=mcModuloMovPoliza.Modulo=<T>{Info.Modulo}<T> AND<BR>mcModuloMovPoliza.Mov=<T>{Info.Mov}<T>

[Lista.mcModuloMovPoliza.Mayor]
Carpeta=Lista
Clave=mcModuloMovPoliza.Mayor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mayor=112
Condicion=304
AfectarDestino=80
Debe=149
Haber=124
Descripcion=203
Nombre=140
Presupuesto=140
PresupuestoTipo=52
Existencia=122
ExistenciaTipo=42
porSurtir=125
porSurtirTipo=64

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

[Condicion.mcModuloMovPoliza.Condicion]
Carpeta=Condicion
Clave=mcModuloMovPoliza.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10x10
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Condicion]
Nombre=Condicion
Boton=35
NombreEnBoton=S
NombreDesplegar=&Condición
EnBarraHerramientas=S
TipoAccion=Expresion
GuardarAntes=S
Expresion=Asigna(mcModuloMovPoliza:mcModuloMovPoliza.Condicion, EditorTextos(<T>Condición<T>, mcModuloMovPoliza:mcModuloMovPoliza.Condicion))<BR>EjecutarSQL(<T>spmcModuloMovPolizaCondicion :tModulo, :tMov, :nID, :tCondicion<T>, mcModuloMovPoliza:mcModuloMovPoliza.Modulo, mcModuloMovPoliza:mcModuloMovPoliza.Mov, mcModuloMovPoliza:mcModuloMovPoliza.RID, mcModuloMovPoliza:mcModuloMovPoliza.Condicion)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=mcModuloMovPoliza
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
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.mcModuloMovPoliza.Debe]
Carpeta=Ficha
Clave=mcModuloMovPoliza.Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=121
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.mcModuloMovPoliza.Haber]
Carpeta=Ficha
Clave=mcModuloMovPoliza.Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=121
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcModuloMovPoliza.Debe]
Carpeta=Lista
Clave=mcModuloMovPoliza.Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcModuloMovPoliza.Haber]
Carpeta=Lista
Clave=mcModuloMovPoliza.Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcModuloMovPoliza.AfectarDestino]
Carpeta=Ficha
Clave=mcModuloMovPoliza.AfectarDestino
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcMayor.Nombre]
Carpeta=Lista
Clave=mcMayor.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=$00408080

[Ficha.mcModuloMovPoliza.Condicion]
Carpeta=Ficha
Clave=mcModuloMovPoliza.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=121x5
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.mcModuloMovPoliza.Mayor]
Carpeta=Ficha
Clave=mcModuloMovPoliza.Mayor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcMayor.Nombre]
Carpeta=Ficha
Clave=mcMayor.Nombre
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro
Editar=S

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

[Presupuesto.mcModuloMovPoliza.PresupuestoInc]
Carpeta=Presupuesto
Clave=mcModuloMovPoliza.PresupuestoInc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=128
ColorFondo=Blanco
ColorFuente=Negro

[Presupuesto.mcModuloMovPoliza.PresupuestoDec]
Carpeta=Presupuesto
Clave=mcModuloMovPoliza.PresupuestoDec
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=128
ColorFondo=Blanco
ColorFuente=Negro

[Presupuesto.mcModuloMovPoliza.PresupuestoTipo]
Carpeta=Presupuesto
Clave=mcModuloMovPoliza.PresupuestoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Existencia.mcModuloMovPoliza.ExistenciaInc]
Carpeta=Existencia
Clave=mcModuloMovPoliza.ExistenciaInc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=128
ColorFondo=Blanco
ColorFuente=Negro

[Existencia.mcModuloMovPoliza.ExistenciaDec]
Carpeta=Existencia
Clave=mcModuloMovPoliza.ExistenciaDec
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=128
ColorFondo=Blanco
ColorFuente=Negro

[Existencia.mcModuloMovPoliza.ExistenciaTipo]
Carpeta=Existencia
Clave=mcModuloMovPoliza.ExistenciaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[porSurtir.mcModuloMovPoliza.porSurtirInc]
Carpeta=porSurtir
Clave=mcModuloMovPoliza.porSurtirInc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=128
ColorFondo=Blanco
ColorFuente=Negro

[porSurtir.mcModuloMovPoliza.porSurtirDec]
Carpeta=porSurtir
Clave=mcModuloMovPoliza.porSurtirDec
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=128
ColorFondo=Blanco
ColorFuente=Negro

[porSurtir.mcModuloMovPoliza.porSurtirTipo]
Carpeta=porSurtir
Clave=mcModuloMovPoliza.porSurtirTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcModuloMovPoliza.Presupuesto]
Carpeta=Ficha
Clave=mcModuloMovPoliza.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcModuloMovPoliza.Existencia]
Carpeta=Ficha
Clave=mcModuloMovPoliza.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcModuloMovPoliza.porSurtir]
Carpeta=Ficha
Clave=mcModuloMovPoliza.porSurtir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcModuloMovPoliza.Presupuesto]
Carpeta=Lista
Clave=mcModuloMovPoliza.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcModuloMovPoliza.Existencia]
Carpeta=Lista
Clave=mcModuloMovPoliza.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcModuloMovPoliza.porSurtir]
Carpeta=Lista
Clave=mcModuloMovPoliza.porSurtir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
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

[Ficha.mcModuloMovPoliza.PresupuestoNombre]
Carpeta=Ficha
Clave=mcModuloMovPoliza.PresupuestoNombre
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcModuloMovPoliza.ExistenciaNombre]
Carpeta=Ficha
Clave=mcModuloMovPoliza.ExistenciaNombre
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcModuloMovPoliza.porSurtirNombre]
Carpeta=Ficha
Clave=mcModuloMovPoliza.porSurtirNombre
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=Condicion
Condicion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=mcModuloMovPoliza.Mayor
mcModuloMovPoliza.Mayor=mcMayor.Nombre
mcMayor.Nombre=mcModuloMovPoliza.Debe
mcModuloMovPoliza.Debe=mcModuloMovPoliza.Haber
mcModuloMovPoliza.Haber=mcModuloMovPoliza.Presupuesto
mcModuloMovPoliza.Presupuesto=mcModuloMovPoliza.Existencia
mcModuloMovPoliza.Existencia=mcModuloMovPoliza.porSurtir
mcModuloMovPoliza.porSurtir=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=mcModuloMovPoliza.Mayor
mcModuloMovPoliza.Mayor=mcMayor.Nombre
mcMayor.Nombre=mcModuloMovPoliza.Condicion
mcModuloMovPoliza.Condicion=mcModuloMovPoliza.Debe
mcModuloMovPoliza.Debe=mcModuloMovPoliza.Haber
mcModuloMovPoliza.Haber=mcModuloMovPoliza.Presupuesto
mcModuloMovPoliza.Presupuesto=mcModuloMovPoliza.PresupuestoNombre
mcModuloMovPoliza.PresupuestoNombre=mcModuloMovPoliza.Existencia
mcModuloMovPoliza.Existencia=mcModuloMovPoliza.ExistenciaNombre
mcModuloMovPoliza.ExistenciaNombre=mcModuloMovPoliza.porSurtir
mcModuloMovPoliza.porSurtir=mcModuloMovPoliza.porSurtirNombre
mcModuloMovPoliza.porSurtirNombre=mcModuloMovPoliza.AfectarDestino
mcModuloMovPoliza.AfectarDestino=(Fin)
