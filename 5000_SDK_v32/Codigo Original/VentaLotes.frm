[Forma]
Clave=VentaLotes
Nombre=Herramienta - Venta Lote
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
ListaCarpetas=VentaLotes
CarpetaPrincipal=VentaLotes
PosicionInicialIzquierda=273
PosicionInicialArriba=211
PosicionInicialAlturaCliente=317
PosicionInicialAncho=482
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionSec1=264
BarraAyudaBold=S
ExpresionesAlMostrar=Asigna(Info.EstacionTrabajo, EstacionTrabajo)<BR>Asigna(Info.Mensaje, nulo)
[VentaLotes]
Estilo=Ficha
Clave=VentaLotes
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaLotes
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
CarpetaVisible=S
ListaEnCaptura=(Lista)
[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar y &Afectar
EnBarraHerramientas=S
Visible=S
GuardarAntes=S
TipoAccion=Expresion
EspacioPrevio=S
Expresion=Si (VentaLotes:VentaLotes.CopiarEnTiempo = Verdadero)<BR> Entonces<BR>   Si (VentaLotes:VentaLotes.FechaD = Nulo) o (VentaLotes:VentaLotes.FechaA = Nulo) o (VentaLotes:VentaLotes.Unidad = Nulo)<BR>    Entonces<BR>        Informacion(<T>Indique los Campos necesarios para Copiar En Tiempo<T>)<BR>        AbortarOperacion<BR>   Fin<BR>Fin<BR>Asigna( Info.Mensaje, SQL(<T>spGenerarVentaLote :tEmp, :tUser, :tEstacion, :tCat, :tFam, :tGpo, :nOk, :tOkRef, :bOpc<T>, {Empresa},{Usuario},{EstacionTrabajo},VentaLotes:VentaLotes.Categoria,VentaLotes:VentaLotes.Familia,VentaLotes:VentaLotes.Grupo,nulo,nulo,0))<BR>Informacion( Info.Mensaje )<BR>ActualizarForma(<T>VentaLotes<T>)
ActivoCondicion=Info.Mensaje = <T>Agrupaciones Correctas<T>
[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
Carpeta=(Carpeta principal)
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Generar.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
[Acciones.Generar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S
[VentaLotes.VentaLotes.Articulo]
Carpeta=VentaLotes
Clave=VentaLotes.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
[VentaLotes.VentaLotes.Mov]
Carpeta=VentaLotes
Clave=VentaLotes.Mov
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[VentaLotes.VentaLotes.Almacen]
Carpeta=VentaLotes
Clave=VentaLotes.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
[VentaLotes.VentaLotes.Categoria]
Carpeta=VentaLotes
Clave=VentaLotes.Categoria
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S
[VentaLotes.VentaLotes.Familia]
Carpeta=VentaLotes
Clave=VentaLotes.Familia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
[VentaLotes.VentaLotes.Grupo]
Carpeta=VentaLotes
Clave=VentaLotes.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[VentaLotes.VentaLotes.Concepto]
Carpeta=VentaLotes
Clave=VentaLotes.Concepto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
[VentaLotes.VentaLotes.CicloEsc]
Carpeta=VentaLotes
Clave=VentaLotes.CicloEsc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S
Tamano=20
[VentaLotes.VentaLotes.Condicion]
Carpeta=VentaLotes
Clave=VentaLotes.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
[VentaLotes.VentaLotes.FechaEmision]
Carpeta=VentaLotes
Clave=VentaLotes.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[VentaLotes.VentaLotes.CopiarEnTiempo]
Carpeta=VentaLotes
Clave=VentaLotes.CopiarEnTiempo
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=20
[VentaLotes.VentaLotes.AplicaDesc]
Carpeta=VentaLotes
Clave=VentaLotes.AplicaDesc
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S
Tamano=31
[VentaLotes.VentaLotes.FechaD]
Carpeta=VentaLotes
Clave=VentaLotes.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S
Tamano=20
[VentaLotes.VentaLotes.FechaA]
Carpeta=VentaLotes
Clave=VentaLotes.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
Pegado=N
[Acciones.Generar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna( Info.Mensaje, SQL(<T>spVentaLotes :tEmp, :tUser, :tEstacion, :tCat, :tFam, :tGpo, :nOk, :tOkRef, :bOpc<T>, {Empresa},{Usuario},{EstacionTrabajo},VentaLotes:VentaLotes.Categoria,VentaLotes:VentaLotes.Familia,VentaLotes:VentaLotes.Grupo,nulo,nulo,1))<BR>Informacion( Info.Mensaje )<BR>ActualizarForma(<T>VentaLotes<T>)
[(Variables).Info.TiempoUnidad]
Carpeta=(Variables)
Clave=Info.TiempoUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S
[VentaLotes.VentaLotes.Unidad]
Carpeta=VentaLotes
Clave=VentaLotes.Unidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spVentaLotesBorrar :tEstacion<T>, EstacionTrabajo)
[Acciones.Cancelar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
[Acciones.Verificar]
Nombre=Verificar
Boton=41
NombreEnBoton=S
NombreDesplegar=&Verificar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.EstacionTrabajo, EstacionTrabajo)
[Acciones.Verificar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
[Acciones.Verificar.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
[Acciones.Verificar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion




Expresion=Si (VentaLotes:VentaLotes.CopiarEnTiempo = Verdadero)<BR> Entonces<BR>   Si (VentaLotes:VentaLotes.FechaD = Nulo) o (VentaLotes:VentaLotes.FechaA = Nulo) o (VentaLotes:VentaLotes.Unidad = Nulo)<BR>    Entonces<BR>        Informacion(<T>Indique los Campos necesarios para Copiar En Tiempo<T>)<BR>        AbortarOperacion<BR>   Fin<BR>Fin<BR>Asigna( Info.Mensaje, SQL(<T>spGenerarVentaLote :tEmp, :tUser, :tEstacion, :tCat, :tFam, :tGpo, :nOk, :tOkRef, :bOpc<T>, {Empresa},{Usuario},{EstacionTrabajo},VentaLotes:VentaLotes.Categoria,VentaLotes:VentaLotes.Familia,VentaLotes:VentaLotes.Grupo,nulo,nulo,1))<BR>Informacion( Info.Mensaje )<BR>ActualizarForma(<T>VentaLotes<T>)
[VentaLotes.ListaEnCaptura]
(Inicio)=VentaLotes.Articulo
VentaLotes.Articulo=VentaLotes.Mov
VentaLotes.Mov=VentaLotes.Almacen
VentaLotes.Almacen=VentaLotes.Categoria
VentaLotes.Categoria=VentaLotes.Familia
VentaLotes.Familia=VentaLotes.Grupo
VentaLotes.Grupo=VentaLotes.Concepto
VentaLotes.Concepto=VentaLotes.CicloEsc
VentaLotes.CicloEsc=VentaLotes.Condicion
VentaLotes.Condicion=VentaLotes.FechaEmision
VentaLotes.FechaEmision=VentaLotes.ContUso
VentaLotes.ContUso=VentaLotes.FechaD
VentaLotes.FechaD=VentaLotes.FechaA
VentaLotes.FechaA=VentaLotes.Unidad
VentaLotes.Unidad=VentaLotes.AplicaDesc
VentaLotes.AplicaDesc=VentaLotes.CopiarEnTiempo
VentaLotes.CopiarEnTiempo=(Fin)

[VentaLotes.VentaLotes.ContUso]
Carpeta=VentaLotes
Clave=VentaLotes.ContUso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro






[Lista.Columnas]
Articulo=131
Descripcion1=244
Almacen=90
Nombre=229
Grupo=100
Sucursal=46








[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cancelar Cambios
Cancelar Cambios=Cerrar
Cerrar=(Fin)
















[Acciones.Verificar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Guardar Cambios
Guardar Cambios=Expresion
Expresion=(Fin)



[Forma.ListaAcciones]
(Inicio)=Verificar
Verificar=Afectar
Afectar=Cancelar
Cancelar=(Fin)
