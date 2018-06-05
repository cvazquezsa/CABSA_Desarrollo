
[Forma]
Clave=POSComisiones
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración comisiones
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Detalle
CarpetaPrincipal=Detalle
PosicionInicialAlturaCliente=253
PosicionInicialAncho=288
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaColor=Plata
ExpresionesAlActivar=ActualizarForma
PosicionInicialIzquierda=539
PosicionInicialArriba=218
Comentarios=Info.Articulo
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y cerrar
GuardarAntes=S
GuardarConfirmar=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Detalle]
Estilo=Ficha
Clave=Detalle
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSComisiones
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PermiteEditar=S
FiltroGeneral=Servicio = <T>{Info.Articulo}<T>
[Detalle.POSComisiones.IdTipoComision]
Carpeta=Detalle
Clave=POSComisiones.IdTipoComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.POSComisiones.IdTipoCobroComision]
Carpeta=Detalle
Clave=POSComisiones.IdTipoCobroComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10
[Detalle.POSComisiones.Valor]
Carpeta=Detalle
Clave=POSComisiones.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10
[Detalle.POSComisiones.Genera]
Carpeta=Detalle
Clave=POSComisiones.Genera
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.POSComisiones.Concepto]
Carpeta=Detalle
Clave=POSComisiones.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco

[Detalle.POSComisiones.Proveedor]
Carpeta=Detalle
Clave=POSComisiones.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Detalle.POSComisiones.Cliente]
Carpeta=Detalle
Clave=POSComisiones.Cliente
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[Detalle.POSTipoComisiones.TipoComision]
Carpeta=Detalle
Clave=POSTipoComisiones.TipoComision
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Detalle.POSTipoCobroComisiones.TipoCobroComision]
Carpeta=Detalle
Clave=POSTipoCobroComisiones.TipoCobroComision
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata







[Lista.Columnas]
IdTipoComision=76
TipoComision=110
IdTipoCobroComision=35
TipoCobroComision=168
Cliente=117
Nombre=293
RFC=107



0=116
1=266

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=Eliminar
GuardarConfirmar=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

















Carpeta=Detalle






NombreEnBoton=S




[Detalle.ListaEnCaptura]
(Inicio)=POSComisiones.IdTipoComision
POSComisiones.IdTipoComision=POSTipoComisiones.TipoComision
POSTipoComisiones.TipoComision=POSComisiones.IdTipoCobroComision
POSComisiones.IdTipoCobroComision=POSTipoCobroComisiones.TipoCobroComision
POSTipoCobroComisiones.TipoCobroComision=POSComisiones.Valor
POSComisiones.Valor=POSComisiones.Genera
POSComisiones.Genera=POSComisiones.Proveedor
POSComisiones.Proveedor=POSComisiones.Cliente
POSComisiones.Cliente=POSComisiones.Concepto
POSComisiones.Concepto=(Fin)





[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Eliminar
Eliminar=(Fin)
