
[Forma]
Clave=ProvSAT
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración de Proveedores
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=Guardar
PosicionInicialIzquierda=373
PosicionInicialArriba=207
PosicionInicialAlturaCliente=275
PosicionInicialAncho=619
Comentarios=Info.Proveedor
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProvSAT
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

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=Prov.Proveedor=<T>{Info.Proveedor}<T>
FiltroRespetar=S
FiltroTipo=General
[Lista.Prov.Proveedor]
Carpeta=Lista
Clave=Prov.Proveedor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=N
3D=S
Pegado=S
Tamano=43
ColorFondo=Blanco

[Lista.Prov.Direccion]
Carpeta=Lista
Clave=Prov.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco

[Lista.Prov.DireccionNumero]
Carpeta=Lista
Clave=Prov.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Lista.Prov.DireccionNumeroInt]
Carpeta=Lista
Clave=Prov.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Lista.Prov.EntreCalles]
Carpeta=Lista
Clave=Prov.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Prov.Plano]
Carpeta=Lista
Clave=Prov.Plano
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Prov.Observaciones]
Carpeta=Lista
Clave=Prov.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Prov.Delegacion]
Carpeta=Lista
Clave=Prov.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Prov.Colonia]
Carpeta=Lista
Clave=Prov.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Prov.CodigoPostal]
Carpeta=Lista
Clave=Prov.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Prov.Poblacion]
Carpeta=Lista
Clave=Prov.Poblacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Prov.Estado]
Carpeta=Lista
Clave=Prov.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Lista.Prov.Pais]
Carpeta=Lista
Clave=Prov.Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Prov.FiscalRegimen]
Carpeta=Lista
Clave=Prov.FiscalRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Lista.Prov.Ruta]
Carpeta=Lista
Clave=Prov.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco












[Lista.Columnas]
SATEstado.Descripcion=129
SATMunicipio.Descripcion=123
SATColonia.Descripcion=296
SATCatCP.ClaveCP=104
SATLocalidad.Descripcion=137

[Lista.ListaEnCaptura]
(Inicio)=Prov.Proveedor
Prov.Proveedor=Prov.Nombre
Prov.Nombre=Prov.Direccion
Prov.Direccion=Prov.DireccionNumero
Prov.DireccionNumero=Prov.DireccionNumeroInt
Prov.DireccionNumeroInt=Prov.EntreCalles
Prov.EntreCalles=Prov.Plano
Prov.Plano=Prov.Observaciones
Prov.Observaciones=Prov.Delegacion
Prov.Delegacion=Prov.Colonia
Prov.Colonia=Prov.CodigoPostal
Prov.CodigoPostal=Prov.Ruta
Prov.Ruta=Prov.Poblacion
Prov.Poblacion=Prov.Estado
Prov.Estado=Prov.Pais
Prov.Pais=Prov.FiscalRegimen
Prov.FiscalRegimen=(Fin)
