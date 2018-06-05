
[Forma]
Clave=PersonalExpress
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Personal Express
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=475
PosicionInicialAncho=623
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=371
PosicionInicialArriba=128
ListaAcciones=(Lista)
IniciarAgregando=S























VentanaExclusiva=S
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

EspacioPrevio=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S










ConCondicion=S
Antes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)
[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Ventana]
Nombre=Ventana
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar
Cancelar=Ventana
Ventana=(Fin)








[Ficha]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
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
[Ficha.ListaEnCaptura]
(Inicio)=Personal.Personal
Personal.Personal=Personal.Tipo
Personal.Tipo=Personal.Estatus
Personal.Estatus=Personal.Empresa
Personal.Empresa=Personal.ApellidoPaterno
Personal.ApellidoPaterno=Personal.ApellidoMaterno
Personal.ApellidoMaterno=Personal.Nombre
Personal.Nombre=Personal.Direccion
Personal.Direccion=Personal.DireccionNumero
Personal.DireccionNumero=Personal.DireccionNumeroInt
Personal.DireccionNumeroInt=Personal.EntreCalles
Personal.EntreCalles=Personal.Plano
Personal.Plano=Personal.Observaciones
Personal.Observaciones=Personal.Delegacion
Personal.Delegacion=Personal.Colonia
Personal.Colonia=Personal.CodigoPostal
Personal.CodigoPostal=Personal.Poblacion
Personal.Poblacion=Personal.Estado
Personal.Estado=Personal.Pais
Personal.Pais=Personal.Telefono
Personal.Telefono=Personal.eMail
Personal.eMail=Personal.FechaNacimiento
Personal.FechaNacimiento=Personal.ZonaEconomica
Personal.ZonaEconomica=Personal.Registro
Personal.Registro=Personal.Registro2
Personal.Registro2=Personal.Registro3
Personal.Registro3=(Fin)

[Ficha.Personal.Personal]
Carpeta=Ficha
Clave=Personal.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Tipo]
Carpeta=Ficha
Clave=Personal.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Estatus]
Carpeta=Ficha
Clave=Personal.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Empresa]
Carpeta=Ficha
Clave=Personal.Empresa
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.ApellidoPaterno]
Carpeta=Ficha
Clave=Personal.ApellidoPaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.ApellidoMaterno]
Carpeta=Ficha
Clave=Personal.ApellidoMaterno
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Nombre]
Carpeta=Ficha
Clave=Personal.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Ficha.Personal.Direccion]
Carpeta=Ficha
Clave=Personal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Blanco

[Ficha.Personal.DireccionNumero]
Carpeta=Ficha
Clave=Personal.DireccionNumero
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.DireccionNumeroInt]
Carpeta=Ficha
Clave=Personal.DireccionNumeroInt
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.EntreCalles]
Carpeta=Ficha
Clave=Personal.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Plano]
Carpeta=Ficha
Clave=Personal.Plano
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Observaciones]
Carpeta=Ficha
Clave=Personal.Observaciones
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Delegacion]
Carpeta=Ficha
Clave=Personal.Delegacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Colonia]
Carpeta=Ficha
Clave=Personal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.CodigoPostal]
Carpeta=Ficha
Clave=Personal.CodigoPostal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Poblacion]
Carpeta=Ficha
Clave=Personal.Poblacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Estado]
Carpeta=Ficha
Clave=Personal.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Pais]
Carpeta=Ficha
Clave=Personal.Pais
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Telefono]
Carpeta=Ficha
Clave=Personal.Telefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Ficha.Personal.eMail]
Carpeta=Ficha
Clave=Personal.eMail
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.FechaNacimiento]
Carpeta=Ficha
Clave=Personal.FechaNacimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.ZonaEconomica]
Carpeta=Ficha
Clave=Personal.ZonaEconomica
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Ficha.Personal.Registro]
Carpeta=Ficha
Clave=Personal.Registro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Ficha.Personal.Registro2]
Carpeta=Ficha
Clave=Personal.Registro2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Personal.Registro3]
Carpeta=Ficha
Clave=Personal.Registro3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
