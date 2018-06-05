[Forma]
Clave=CteEnviarASAT
Icono=4
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración de Sucursales de Clientes
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0

ListaCarpetas=Detalles
CarpetaPrincipal=Detalles
ListaAcciones=Guardar
PosicionInicialIzquierda=373
PosicionInicialArriba=207
PosicionInicialAlturaCliente=275
PosicionInicialAncho=619
PosicionCol1=315
Comentarios=Lista(Info.Cliente, Info.ID)

[Lista.CteEnviarA.Nombre]
Carpeta=Lista
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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


[Detalles]
Estilo=Ficha
Clave=Detalles
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteEnviarASAT
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
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
FiltroGeneral=CteEnviarA.Cliente=<T>{Info.Cliente}<T> AND CteEnviarA.ID = {Info.ID}
[Detalles.CteEnviarA.Direccion]
Carpeta=Detalles
Clave=CteEnviarA.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco

[Detalles.CteEnviarA.DireccionNumero]
Carpeta=Detalles
Clave=CteEnviarA.DireccionNumero
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=6
ColorFondo=Blanco

Pegado=S
[Detalles.CteEnviarA.DireccionNumeroInt]
Carpeta=Detalles
Clave=CteEnviarA.DireccionNumeroInt
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=6
ColorFondo=Blanco

Pegado=S
[Detalles.CteEnviarA.EntreCalles]
Carpeta=Detalles
Clave=CteEnviarA.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalles.CteEnviarA.Plano]
Carpeta=Detalles
Clave=CteEnviarA.Plano
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.CteEnviarA.Observaciones]
Carpeta=Detalles
Clave=CteEnviarA.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalles.CteEnviarA.Delegacion]
Carpeta=Detalles
Clave=CteEnviarA.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.CteEnviarA.Colonia]
Carpeta=Detalles
Clave=CteEnviarA.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalles.CteEnviarA.CodigoPostal]
Carpeta=Detalles
Clave=CteEnviarA.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.CteEnviarA.Poblacion]
Carpeta=Detalles
Clave=CteEnviarA.Poblacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.CteEnviarA.Estado]
Carpeta=Detalles
Clave=CteEnviarA.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalles.CteEnviarA.Pais]
Carpeta=Detalles
Clave=CteEnviarA.Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.CteEnviarA.FiscalRegimen]
Carpeta=Detalles
Clave=CteEnviarA.FiscalRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Clave
CteEnviarA.Clave=(Fin)


[Lista.Columnas]
0=60
1=239
2=-2






FiscalRegimen=124
Descripcion=362
Extranjero=64



[Detalles.CteEnviarA.Ruta]
Carpeta=Detalles
Clave=CteEnviarA.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco











[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalles
Detalles=(Fin)






[Detalles.CteEnviarA.Nombre]
Carpeta=Detalles
Clave=CteEnviarA.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=63
ColorFondo=Plata

[Detalles.ListaEnCaptura]
(Inicio)=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Direccion
CteEnviarA.Direccion=CteEnviarA.DireccionNumero
CteEnviarA.DireccionNumero=CteEnviarA.DireccionNumeroInt
CteEnviarA.DireccionNumeroInt=CteEnviarA.EntreCalles
CteEnviarA.EntreCalles=CteEnviarA.Plano
CteEnviarA.Plano=CteEnviarA.Observaciones
CteEnviarA.Observaciones=CteEnviarA.Delegacion
CteEnviarA.Delegacion=CteEnviarA.Colonia
CteEnviarA.Colonia=CteEnviarA.CodigoPostal
CteEnviarA.CodigoPostal=CteEnviarA.Ruta
CteEnviarA.Ruta=CteEnviarA.Poblacion
CteEnviarA.Poblacion=CteEnviarA.Estado
CteEnviarA.Estado=CteEnviarA.Pais
CteEnviarA.Pais=CteEnviarA.FiscalRegimen
CteEnviarA.FiscalRegimen=(Fin)
