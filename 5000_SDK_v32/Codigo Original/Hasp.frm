[Forma]
Clave=Hasp
Nombre=HASP<T>s
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=226
PosicionInicialArriba=243
PosicionInicialAlturaCliente=511
PosicionInicialAncho=827
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.Cliente, Nulo)
PosicionCol1=347
PosicionSec1=224

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Hasp
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Hasp.ID<TAB>(Acendente)
CarpetaVisible=S
HojaMantenerSeleccion=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasCampo=Hasp.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Vencimiento
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

[Lista.Hasp.ID]
Carpeta=Lista
Clave=Hasp.ID
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
ID=65
Fabricacion=90
Vencimiento=102
Mantenimiento=92
Cliente=72
Estatus=61
Nombre=178

[Lista.Hasp.Cliente]
Carpeta=Lista
Clave=Hasp.Cliente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Actuales
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Hasp
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S

[Ficha.Hasp.ID]
Carpeta=Ficha
Clave=Hasp.ID
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
Efectos=[Negritas]

[Ficha.Hasp.Cliente]
Carpeta=Ficha
Clave=Hasp.Cliente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Hasp.Fabricacion]
Carpeta=Ficha
Clave=Hasp.Fabricacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Ficha.Hasp.Vencimiento]
Carpeta=Ficha
Clave=Hasp.Vencimiento
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Ficha.Hasp.Mantenimiento]
Carpeta=Ficha
Clave=Hasp.Mantenimiento
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Ficha.Hasp.Licencias1]
Carpeta=Ficha
Clave=Hasp.Licencias1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Ficha.Hasp.Licencias2]
Carpeta=Ficha
Clave=Hasp.Licencias2
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Ficha.Hasp.Estatus]
Carpeta=Ficha
Clave=Hasp.Estatus
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Hasp.Observaciones]
Carpeta=Ficha
Clave=Hasp.Observaciones
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro

[Modificaciones.Hasp.ID]
Carpeta=Modificaciones
Clave=Hasp.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Modificaciones.Hasp.ClienteN]
Carpeta=Modificaciones
Clave=Hasp.ClienteN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Modificaciones.CteDestino.Nombre]
Carpeta=Modificaciones
Clave=CteDestino.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Modificaciones.Hasp.FabricacionN]
Carpeta=Modificaciones
Clave=Hasp.FabricacionN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Modificaciones.Hasp.VencimientoN]
Carpeta=Modificaciones
Clave=Hasp.VencimientoN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Modificaciones.Hasp.MantenimientoN]
Carpeta=Modificaciones
Clave=Hasp.MantenimientoN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Modificaciones.Hasp.Licencias1N]
Carpeta=Modificaciones
Clave=Hasp.Licencias1N
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Modificaciones.Hasp.Licencias2N]
Carpeta=Modificaciones
Clave=Hasp.Licencias2N
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Modificaciones.Hasp.EstatusN]
Carpeta=Modificaciones
Clave=Hasp.EstatusN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Modificaciones.Hasp.ObservacionesN]
Carpeta=Modificaciones
Clave=Hasp.ObservacionesN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Hasp.ClienteN]
Carpeta=Ficha
Clave=Hasp.ClienteN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.CteDestino.Nombre]
Carpeta=Ficha
Clave=CteDestino.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Hasp.FabricacionN]
Carpeta=Ficha
Clave=Hasp.FabricacionN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Hasp.VencimientoN]
Carpeta=Ficha
Clave=Hasp.VencimientoN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Hasp.MantenimientoN]
Carpeta=Ficha
Clave=Hasp.MantenimientoN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Hasp.Licencias1N]
Carpeta=Ficha
Clave=Hasp.Licencias1N
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Hasp.Licencias2N]
Carpeta=Ficha
Clave=Hasp.Licencias2N
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Hasp.EstatusN]
Carpeta=Ficha
Clave=Hasp.EstatusN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Hasp.ObservacionesN]
Carpeta=Ficha
Clave=Hasp.ObservacionesN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
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
Visible=S
ActivoCondicion=Vacio(Hasp:Hasp.Cliente)

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Ficha.Hasp.FechaAutorizacion]
Carpeta=Ficha
Clave=Hasp.FechaAutorizacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Hasp.UsuarioAutorizacion]
Carpeta=Ficha
Clave=Hasp.UsuarioAutorizacion
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Usuario.Nombre]
Carpeta=Ficha
Clave=Usuario.Nombre
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Autorizar]
Nombre=Autorizar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Autorizar Cambios
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=HASP.Autorizar(Hasp:Hasp.ID, Hasp:Hasp.Tipo, Vacio(Hasp:Hasp.EstatusN, Hasp:Hasp.Estatus), Vacio(Hasp:Hasp.FabricacionN, Hasp:Hasp.Fabricacion), Vacio(Hasp:Hasp.VencimientoN, Hasp:Hasp.Vencimiento), Vacio(Hasp:Hasp.MantenimientoN, Hasp:Hasp.Mantenimiento), Vacio(Hasp:Hasp.Licencias1N, Hasp:Hasp.Licencias1), Vacio(Hasp:Hasp.Licencias2N, Hasp:Hasp.Licencias2))

[Ficha.Hasp.Tipo]
Carpeta=Ficha
Clave=Hasp.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=&Actualizar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
EspacioPrevio=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Autorizar
Autorizar=Actualizar
Actualizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Hasp.ID
Hasp.ID=Hasp.Cliente
Hasp.Cliente=Cte.Nombre
Cte.Nombre=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Hasp.ID
Hasp.ID=Hasp.Tipo
Hasp.Tipo=Hasp.Cliente
Hasp.Cliente=Cte.Nombre
Cte.Nombre=Hasp.Fabricacion
Hasp.Fabricacion=Hasp.Vencimiento
Hasp.Vencimiento=Hasp.Mantenimiento
Hasp.Mantenimiento=Hasp.Licencias1
Hasp.Licencias1=Hasp.Licencias2
Hasp.Licencias2=Hasp.Estatus
Hasp.Estatus=Hasp.Observaciones
Hasp.Observaciones=Hasp.FechaAutorizacion
Hasp.FechaAutorizacion=Hasp.UsuarioAutorizacion
Hasp.UsuarioAutorizacion=Usuario.Nombre
Usuario.Nombre=Hasp.ClienteN
Hasp.ClienteN=CteDestino.Nombre
CteDestino.Nombre=Hasp.FabricacionN
Hasp.FabricacionN=Hasp.VencimientoN
Hasp.VencimientoN=Hasp.MantenimientoN
Hasp.MantenimientoN=Hasp.Licencias1N
Hasp.Licencias1N=Hasp.Licencias2N
Hasp.Licencias2N=Hasp.EstatusN
Hasp.EstatusN=Hasp.ObservacionesN
Hasp.ObservacionesN=(Fin)
